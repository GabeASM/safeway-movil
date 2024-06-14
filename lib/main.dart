import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safeway/landing/screens/lading_screen.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'El servicio de localización no está habilitado';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Permisos de localización denegados';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Permisos de localización denegados permanentemente';
  }

  return await Geolocator.getCurrentPosition();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    runApp(const App());
    IO.Socket socket = IO.io('http://192.168.1.172:8081',
        IO.OptionBuilder().setTransports(['websocket']).build());

    // Escuchar eventos de conexión y mensajes
    socket.on('connect', (_) {
      print('Conectado al servidor de sockets');
    });

    socket.on('notifications', (data) {
      print('Mensaje recibido: $data');
    });
    socket.on('disconnect', (_) {
      print('Desconectado del servidor de sockets');
    });

    // Iniciar un bucle para enviar la ubicación cada x segundos
    while (true) {
      var position = await _determinePosition();
      socket.emit('sendLocation',
          {'latitude': position.latitude, 'longitude': position.longitude});
      await Future.delayed(const Duration(seconds: 30));
    }
  } catch (e) {
    print('Error durante la inicialización: $e');
    runApp(
        const App()); // Ejecuta la aplicación incluso si falla la inicialización
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
    );
  }
}
