import 'package:flutter/material.dart';
import 'package:safeway/users/widgets/logo.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: LogoSafeWay(),
          ),
        )
      ],
    ));
  }
}
