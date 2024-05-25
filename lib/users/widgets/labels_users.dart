import 'package:flutter/material.dart';

class LabelFormUser extends StatelessWidget {
  final String text;

  const LabelFormUser({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
