import 'package:flutter/material.dart';

class UserNameField extends StatefulWidget {
  const UserNameField({super.key, required this.userNameController});

  final TextEditingController userNameController;

  @override
  UserNameFieldState createState() => UserNameFieldState();
}

class UserNameFieldState extends State<UserNameField> {
  String? _errorMessage;

  bool _isValidUserName(String userName) {
    final userNameRegex = RegExp(r'^[a-z0-9_]+$');
    return userNameRegex.hasMatch(userName);
  }

  @override
  void initState() {
    super.initState();
    widget.userNameController.addListener(_validateUserName);
  }

  @override
  void dispose() {
    widget.userNameController.removeListener(_validateUserName);
    super.dispose();
  }

  void _validateUserName() {
    final userName = widget.userNameController.text;
    if (userName.isEmpty || _isValidUserName(userName)) {
      setState(() {
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage =
            'El nombre de usuario debe estar en minúsculas y solo puede contener letras, números y guiones bajos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.userNameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle_outlined),
        hintText: 'Nombre de usuario',
        hintStyle: const TextStyle(
          fontSize: 13.3,
        ),
        errorText: _errorMessage,
      ),
    );
  }
}
