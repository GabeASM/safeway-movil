import 'package:flutter/material.dart';

class EmailFieldUser extends StatelessWidget {
  const EmailFieldUser({
    super.key,
    required TextEditingController mailController,
  }) : _mailController = mailController;

  final TextEditingController _mailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _mailController,
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.mail_outline,
          ),
          hintText: 'Direccion de correo',
          hintStyle: TextStyle(
            fontSize: 13.3,
          )),
    );
  }
}
