import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safeway/users/models/create_users.dart';
import 'package:safeway/users/models/login_user.dart';
import 'package:safeway/users/models/user_logged.dart';
import 'package:safeway/global/global_network.dart' as network;

class UserServiceApi {
  final Dio _dio = Dio();
  final String baseUrl = 'http://${network.ipNetwork}:8080/';
  final String ipBase = network.ipNetwork;
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', loginResponse.token);
        await prefs.setString('user_name', loginResponse.user.username);
      }

      print(response);
      return response;
    } catch (error) {
      print('Error en el login: $error');
      throw Exception('Error en la solicitud de crear usuarios: $error');
    }
  }
}
