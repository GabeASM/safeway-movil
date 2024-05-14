import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación Actual'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _currentPosition != null
                ? Text(
                    'Latitud: ${_currentPosition!.latitude}, Longitud: ${_currentPosition!.longitude}')
                : const Text('Ubicación no disponible'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getLocation();
              },
              child: const Text('Obtener Ubicación'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

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
}
