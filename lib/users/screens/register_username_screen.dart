import 'package:flutter/material.dart';
import 'package:safeway/users/models/create_users.dart';
import 'package:safeway/users/screens/login_screen.dart';
import 'package:safeway/users/services/user_api_service.dart';
import 'package:safeway/users/widgets/custom_user_button.dart';
import 'package:safeway/users/widgets/labels_users.dart';
import 'package:safeway/users/widgets/logo.dart';
import 'package:safeway/users/widgets/username_field.dart';

class UserNameRegister extends StatefulWidget {
  const UserNameRegister({super.key, required this.user});

  final CreateUser user;
  @override
  State<UserNameRegister> createState() => _UserNameRegisterState();
}

class _UserNameRegisterState extends State<UserNameRegister> {
  final TextEditingController userNameController = TextEditingController();
  var userService = UserServiceApi();
  bool _isLoading = false;

  void _createUser() async {
    setState(() {
      _isLoading = true;
    });

    widget.user.username = userNameController.text;

    try {
      await userService.createUser(widget.user);
      // Mostrar mensaje de éxito y redirigir a la página de inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario creado con éxito')),
      );
      // Espera un momento antes de redirigir
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .push(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()),
      )
          .then((_) {
        Navigator.of(context)
            .pop(); // Eliminar la pantalla de registro del stack
      });
    } catch (error) {
      print('Error en la creación del usuario: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la creación del usuario: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
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
              padding: EdgeInsets.all(70.0),
              child: LogoSafeWay(),
            ),
            const Center(child: LabelFormUser(text: 'Nombre de usuario')),
            const SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Ingrese un nombre de usuario con el que será reconocido en la aplicacion',
                    style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SizedBox(
                  width: 300,
                  child: UserNameField(
                    userNameController: userNameController,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 300,
                      height: 50,
                      child: CustomUserButton(
                        text: 'Enviar',
                        onPressed: _createUser,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
