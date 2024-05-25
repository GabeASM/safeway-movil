import 'package:flutter/material.dart';

class CustomUserButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color customColor = const Color(0xFF52B0A5);

  const CustomUserButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(customColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // radio para cambiar la esquina del rectángulo
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.transparent,
            width: 2.0, // Establece el color y el ancho del borde
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
