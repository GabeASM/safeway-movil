import 'package:flutter/material.dart';

class LogoSafeWay extends StatelessWidget {
  const LogoSafeWay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Image.asset(
        'assets/SafeWayLogo.png', // Ruta de la imagen en los activos
        fit: BoxFit.fitHeight, // Ajusta la imagen al contenedor
      ),
    );
  }
}
