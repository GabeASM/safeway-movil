import 'package:flutter/material.dart';

class EventDetailOnMapScreen extends StatelessWidget {
  final int eventId;
  const EventDetailOnMapScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 125,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.network(
                'https://media.biobiochile.cl/wp-content/uploads/2021/09/whatsapp-image-2021-09-22-at-10-17-35-am-2-1-1024x768.jpeg'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                '27 de junio',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                children: [
                  Text(
                    'Reparacion de via',
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF52B0A5)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Text(
                  'Ver',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
