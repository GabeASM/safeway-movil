import 'package:dio/dio.dart';
import '../../global/globals_user.dart' as globals;
import 'package:safeway/users/models/create_users.dart';
import 'package:safeway/users/models/login_user.dart';
import 'package:safeway/users/models/user_logged.dart';

class UserServiceApi {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.1.172:8080/';
  final String ipBase = '192.168.1.172';
  UserServiceApi() {
    _dio.options.baseUrl = baseUrl;
  }
  Future<dynamic> createUser(CreateUser user) async {
    print("este es el mail ${user.email}");
    try {
      Map<String, dynamic> postData = {
        'username': user.username,
        'mail': user.email,
        'password': user.password
      };

      final response =
          await _dio.post('http://$ipBase:8080/auth/register', data: postData);

      print(response);

      return response;
    } catch (error) {
      print('Error en el login: $error');
      throw Exception('Error en la solicitud de crear usuarios: $error');
    }
  }

  Future<dynamic> login(LoginUser user) async {
    try {
      Map<String, dynamic> postData = {
        'mail': user.mail,
        'password': user.password
      };

      final response =
          await _dio.post('http://$ipBase:8080/auth/login', data: postData);

      Map<String, dynamic> jsonMap = response.data;
      LoginResponse loginResponse = LoginResponse.fromJson(jsonMap);

      if (loginResponse.token.isNotEmpty) {
        globals.isLoggedIn = true;
      }

      print(response);
      return response;
    } catch (error) {
      print('Error en el login: $error');
      throw Exception('Error en la solicitud de crear usuarios: $error');
    }
  }
}
