import 'package:flutter/material.dart';

class CustomTransparentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomTransparentButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // radio para cambiar la esquina del rectángulo
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
      ),
    );
  }
}
