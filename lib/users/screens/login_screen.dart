import 'package:flutter/material.dart';
import 'package:safeway/landing/screens/lading_screen.dart';
import 'package:safeway/users/models/login_user.dart';
import 'package:safeway/users/screens/register_screen.dart';
import 'package:safeway/users/services/user_api_service.dart';
import 'package:safeway/users/widgets/custom_transparent_user_button.dart';
import 'package:safeway/users/widgets/custom_user_button.dart';
import 'package:safeway/users/widgets/labels_users.dart';
import 'package:safeway/users/widgets/logo.dart';
import 'package:safeway/users/widgets/mail_field.dart';
import 'package:safeway/users/widgets/password_login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  var userService = UserServiceApi();

  void _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_mailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _errorMessage = '';
      LoginUser loginUser = LoginUser(
          mail: _mailController.text, password: _passwordController.text);
      try {
        await userService.login(loginUser);
        // Si el login es exitoso, redirigir a LandingScreen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => LandingScreen()),
          (Route<dynamic> route) => false,
        );
        // Mostrar mensaje de éxito en LandingScreen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
      } catch (error) {
        _errorMessage = 'Error en la conexion :(';
        print('Error en la autenticacion del usuario: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Por favor rellena todos los campos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Center(child: LogoSafeWay()),
            ),
            const LabelFormUser(text: 'Iniciar sesión'),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                  width: 300,
                  child: EmailFieldUser(mailController: _mailController)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                  width: 300,
                  child: PasswordLoginField(
                    controller: _passwordController,
                    hintTextPassword: 'Contraseña',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 300,
                      height: 50,
                      child: CustomUserButton(
                          text: 'Ingresar', onPressed: _loginUser)),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: 300,
                  height: 50,
                  child: CustomTransparentButton(
                      text: 'Registrarse',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => RegisterScreen()),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
