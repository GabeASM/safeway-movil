import 'package:flutter/material.dart';
import 'package:safeway/users/models/create_users.dart';
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
              child: SizedBox(
                  width: 300,
                  height: 50,
                  child: CustomUserButton(
                      text: 'Enviar',
                      onPressed: () {
                        widget.user.username = userNameController.text;
                      })),
            )
          ],
        ),
      ),
    );
  }
}
