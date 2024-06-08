import 'package:flutter/material.dart';
import 'package:safeway/events/screens/event_register.dart';

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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((ctx) => const EventForm())));
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
