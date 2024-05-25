import 'package:flutter/material.dart';
import 'package:safeway/users/widgets/labels_users.dart';
import 'package:safeway/users/widgets/logo.dart';
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
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
                width: 300,
                child: TextField(
                  controller: _mailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                      ),
                      hintText: 'Direccion de correo',
                      hintStyle: TextStyle(
                        fontSize: 13.3,
                      )),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
                width: 300,
                child: PasswordField(
                  controller: _passwordController,
                  hintTextPassword: 'Contraseña',
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
                width: 300,
                child: PasswordField(
                  controller: _verifyPasswordController,
                  hintTextPassword: 'Confirmar contraseña',
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: SizedBox(
              width: 300,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(customColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // radio para cambiar la esquina del rectángulo
                    ),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                        color: Colors.transparent,
                        width: 2.0), // Establece el color y el ancho del borde
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          Padding(
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
