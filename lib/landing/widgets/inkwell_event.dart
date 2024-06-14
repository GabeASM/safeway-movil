import 'package:flutter/material.dart';
import 'package:safeway/events/models/received_events.dart';

class InkwellEvent extends StatelessWidget {
  final EventReceived event;
  const InkwellEvent(
      {super.key, required this.onSelectEvent, required this.event});
  final void Function() onSelectEvent;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectEvent,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Imagen de internet usada como placeholder
            Image.network(
              'https://via.placeholder.com/150', // URL de una imagen placeholder
              fit: BoxFit.cover,
              height: 100, // tamaño de la imagen
              width: double.infinity, // Para que ocupe todo el ancho disponible
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  event.category,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
