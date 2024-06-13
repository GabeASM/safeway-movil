import 'package:flutter/material.dart';
import 'package:safeway/landing/screens/lading_screen.dart';

import 'package:safeway/users/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/globals_user.dart' as global;

class CustomLogOutButton extends StatelessWidget {
  final Color customColorLogOut = const Color(0xFFF24747);
  final Color customColorLogIn = const Color(0xFF52B0A5);

  final bool isLogged;
  const CustomLogOutButton({
    super.key,
    required this.isLogged,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLogged) {
      return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(customColorLogIn),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(customColorLogOut),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwt_token');
        await prefs.remove('user_name');
        global.isLoggedIn = false;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const LandingScreen()),
          (Route<dynamic> route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ha cerrado sesión')),
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
