import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safeway/events/models/event.dart';
import 'package:safeway/events/models/received_events.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');

      if (token == null) {
        throw Exception('Usuario no autenticado');
      }

      Position position = await _determinePosition();

      Map<String, dynamic> newEvent = {
        'image': createEvent.image,
        'category': createEvent.category,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'description': createEvent.description,
      };
      print('se está creando este nuevo evento');
      print(newEvent);

      final response = await _dio.post(
        'http://$ipBase:8080/eventmsvc',
        data: newEvent,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("El evento fue creado -> $response");
      return response;
    } catch (error) {
      print('Error al crear el evento: $error');
      throw Exception('Error en la solicitud de crear evento: $error');
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

  Future<List<EventReceived>> getUserEvents() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');

      if (token == null) {
        throw Exception('Usuario no autenticado');
      }

      final response = await _dio.get(
        'http://$ipBase:8080/eventmsvc/event',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      List<dynamic> data = response.data;
      List<EventReceived> events =
          data.map((json) => EventReceived.fromJson(json)).toList();

      print('estos son los eventos del usuario -> $events');
      print("Eventos recibidos: $events");
      return events;
    } catch (error) {
      print('Error al obtener los eventos: $error');
      throw Exception('Error en la solicitud de obtener eventos: $error');
    }
  }
}
