import 'package:flutter/material.dart';

class FormLabels extends StatelessWidget {
  final String text;

  const FormLabels({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, top: 7),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }
}
