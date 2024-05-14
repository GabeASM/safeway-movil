import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safeway/events/models/event.dart';

class EventServiceApi {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.1.172:8080/';
  final String ipBase = '192.168.1.172';
  EventServiceApi() {
    _dio.options.baseUrl = baseUrl;
  }

  Future<dynamic> createEvent(Event createEvent) async {
    try {
      Position position = await _determinePosition();

      Map<String, dynamic> newEvent = {
        'image': "imagen obtenida desde el telefono",
        'category': createEvent.category,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'description': createEvent.description
      };
      print('se esta creando este nuevo evento');
      print(newEvent);

      final response =
          await _dio.post('http://$ipBase:8080/eventmsvc', data: newEvent);
      print("el evento fue creado -> $response");
    } catch (error) {
      print('Error en la solicitud post: $error');
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
