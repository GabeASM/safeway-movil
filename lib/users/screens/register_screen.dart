import 'package:flutter/material.dart';
import 'package:safeway/users/models/create_users.dart';
import 'package:safeway/users/screens/register_username_screen.dart';
import 'package:safeway/users/widgets/custom_user_button.dart';
import 'package:safeway/users/widgets/labels_users.dart';
import 'package:safeway/users/widgets/logo.dart';
import 'package:safeway/users/widgets/mail_field.dart';
import 'package:safeway/users/widgets/password_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final Color customColor = const Color(0xFF52B0A5);
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: LogoSafeWay(),
            ),
          ),
          const Center(
            child: LabelFormUser(text: 'Registro'),
          ),
          Padding(
            // input del mail de usuario
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
                width: 300,
                child: EmailFieldUser(mailController: _mailController)),
          ),
          Padding(
            // Input de contraseña
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
                width: 300,
                child: PasswordField(
                  controller: _passwordController,
                  hintTextPassword: 'Contraseña',
                )),
          ),
          Padding(
            // input para la validacion de la contraseña
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
                width: 300,
                child: PasswordField(
                  controller: _verifyPasswordController,
                  hintTextPassword: 'Confirmar contraseña',
                )),
          ),
          Padding(
            // Boton de enviar formulario
            padding: const EdgeInsets.only(top: 50.0),
            child: SizedBox(
              width: 300,
              height: 50,
              child: CustomUserButton(
                text: 'Siguiente',
                onPressed: () {
                  if (_passwordController.text !=
                      _verifyPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    CreateUser user = CreateUser(
                        _mailController.text, _passwordController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => UserNameRegister(
                          user: user,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            // Boton de inicio de sesion
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: 300,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // radio para cambiar la esquina del rectángulo
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Iniciar sesion',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
