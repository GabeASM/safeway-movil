import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:safeway/events/models/received_events.dart';
import 'package:safeway/events/services/event_api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safeway/events/widgets/labels.dart';

class DetalleEventoScreen extends StatefulWidget {
  const DetalleEventoScreen({Key? key, required this.idEvent})
      : super(key: key);
  final int idEvent;

  @override
  _DetalleEventoScreenState createState() => _DetalleEventoScreenState();
}

class _DetalleEventoScreenState extends State<DetalleEventoScreen> {
  final EventServiceApi _api = EventServiceApi();

  late Future<EventReceived> _eventFuture;
  String _address = '';

  @override
  void initState() {
    super.initState();
    _eventFuture = _api.getEventById(widget.idEvent);
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    try {
      EventReceived event = await _eventFuture;
      List<Placemark> placemarks = await placemarkFromCoordinates(
        event.latitude,
        event.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _address = '${placemark.street}, ${placemark.subLocality}';

          print(' esta es la direccion del evento -> _address');
        });
      } else {
        setState(() {
          _address = 'Dirección no disponible';
        });
      }
    } catch (e) {
      print('Error al obtener la dirección: $e');
      setState(() {
        _address = 'Error al obtener la dirección';
      });
    }
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
      body: FutureBuilder<EventReceived>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No se encontraron datos'));
          } else {
            EventReceived event = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 /
                          9, // Ajusta la relación de aspecto según tus imágenes
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                    ),
                    items: [
                      // Usamos la imagen del evento desde el objeto EventReceived
                      'https://via.placeholder.com/150'
                    ]
                        .map((item) => Center(
                            child: Image.network(item,
                                fit: BoxFit.cover, width: 1000)))
                        .toList(),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 230.0, bottom: 5, top: 15),
                    child: FormLabels(
                      text: 'Dirección',
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      readOnly:
                          true, // Hace que el TextField sea de solo lectura
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: _address,
                        hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 230.0, bottom: 5, top: 15),
                    child: FormLabels(
                      text: 'Categoría',
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      readOnly:
                          true, // Hace que el TextField sea de solo lectura
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: event.category,
                        hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.0, bottom: 5, top: 15),
                    child: FormLabels(
                      text: 'Descripción',
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      readOnly:
                          true, // Hace que el TextField sea de solo lectura
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: event.description,
                        hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
