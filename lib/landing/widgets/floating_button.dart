import 'package:flutter/material.dart';
import 'package:safeway/events/screens/event_register.dart';
import 'package:safeway/global/auth_service.dart';
import 'package:safeway/global/globals_user.dart' as global;

class AddEventFloatingButton extends StatelessWidget {
  const AddEventFloatingButton({
    super.key,
  });

  final Color buttonColorBlack = const Color(0xFF121416);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: FloatingActionButton(
        backgroundColor: buttonColorBlack,
        onPressed: () async {
          if (await AuthService.isLoggedIn()) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const EventForm()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Por favor, inicie sesión para agregar un evento.'),
              ),
            );
          }
        },
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7.0),
              child: Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
            Text(
              'Agregar evento',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
