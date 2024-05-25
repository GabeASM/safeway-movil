import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hintTextPassword;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.hintTextPassword,
    required this.controller,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  String? _errorMessage;

  bool _isValidPassword(String password) {
    // Regla para una contraseña segura:
    // Al menos 8 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePassword);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePassword);
    super.dispose();
  }

  void _validatePassword() {
    final password = widget.controller.text;
    if (password.isEmpty || _isValidPassword(password)) {
      setState(() {
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'La contraseña no es segura';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.remove_red_eye_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        prefixIcon: const Icon(Icons.lock_outlined),
        hintText: widget.hintTextPassword,
        hintStyle: const TextStyle(
          fontSize: 13.3,
        ),
        errorText: _errorMessage,
      ),
    );
  }
}
