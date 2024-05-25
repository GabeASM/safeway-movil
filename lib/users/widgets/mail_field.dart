import 'package:flutter/material.dart';

class EmailFieldUser extends StatefulWidget {
  const EmailFieldUser({super.key, required this.mailController});

  final TextEditingController mailController;

  @override
  EmailFieldUserState createState() => EmailFieldUserState();
}

class EmailFieldUserState extends State<EmailFieldUser> {
  String? _errorMessage;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    widget.mailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    widget.mailController.removeListener(_validateEmail);
    super.dispose();
  }

  void _validateEmail() {
    final email = widget.mailController.text;
    if (email.isEmpty || _isValidEmail(email)) {
      setState(() {
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'El email no es válido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.mailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail_outline),
        hintText: 'Direccion de correo',
        hintStyle: const TextStyle(
          fontSize: 13.3,
        ),
        errorText: _errorMessage,
      ),
    );
  }
}
