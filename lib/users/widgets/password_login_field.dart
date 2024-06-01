import 'package:flutter/material.dart';

class PasswordLoginField extends StatefulWidget {
  final String hintTextPassword;
  final TextEditingController controller;

  const PasswordLoginField({
    super.key,
    required this.hintTextPassword,
    required this.controller,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordLoginField> {
  bool _obscureText = true;

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
      ),
    );
  }
}
