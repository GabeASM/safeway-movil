import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safeway/events/models/event.dart';
import 'package:uuid/uuid.dart';

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
        'image': createEvent.image,
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
      return response;
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

  Future<String?> uploadImageAndGetUrl(File imageFile) async {
    Dio dio = Dio();
    var uuid = const Uuid();

    String uniqueFileName = '${uuid.v4()}.jpg';

    print('unique file -> $uniqueFileName');

    var url = 'http://192.168.1.172:9000/safeway-images/$uniqueFileName';
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: uniqueFileName,
          contentType: MediaType('image',
              'jpeg'), // Ajusta según el tipo de imagen que estás subiendo
        ),
      });
      var response = await dio.put(url, data: formData);
      if (response.statusCode == 200) {
        return response.data.toString(); // Ajusta según la respuesta esperada
      } else {
        print(
            'Error durante la carga de la imagen. Código de estado: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error durante la carga de la imagen: $e');
      return null;
    }
  }
}
