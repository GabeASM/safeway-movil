import 'package:flutter/material.dart';
import 'package:safeway/events/models/received_events.dart';
import 'package:safeway/events/services/event_api_service.dart';
import 'package:safeway/landing/screens/detail_event.dart';
import 'package:safeway/landing/widgets/inkwell_event.dart';

class MisEventosScreen extends StatefulWidget {
  const MisEventosScreen({super.key});

  @override
  MisEventosScreenState createState() => MisEventosScreenState();
}

class MisEventosScreenState extends State<MisEventosScreen> {
  late Future<List<EventReceived>> _futureEvents;
  final EventServiceApi _api = EventServiceApi();

  @override
  void initState() {
    super.initState();
    _futureEvents = _api.getUserEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(),
        ),
        backgroundColor: const Color(0xFF121416),
      ),
      body: FutureBuilder<List<EventReceived>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<EventReceived> events = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // número de columnas
                childAspectRatio:
                    1.0, // Esto asegura que cada item sea cuadrado
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                EventReceived event = events[index];
                return InkwellEvent(
                  event: event,
                  onSelectEvent: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => DetalleEventoScreen(
                                idEvent: event.id,
                              )),
                    );
                    print('Evento seleccionado: ${event.category}');
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No hay eventos disponibles'),
            );
          }
        },
      ),
    );
  }
}
