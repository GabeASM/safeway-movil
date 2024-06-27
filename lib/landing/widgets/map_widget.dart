import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:safeway/events/models/received_events.dart';
import 'package:safeway/events/screens/event_detail_map.dart';
import 'package:safeway/events/services/event_api_service.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final Position? currentLocation;

  const MapWidget({
    super.key,
    required this.initialCenter,
    required this.initialZoom,
    required this.currentLocation,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> _eventMarkers = [];
  List<EventReceived> eventos = [];

  @override
  void initState() {
    super.initState();
    obtenerEventosAMarcadores();
  }

  Future<void> obtenerEventosAMarcadores() async {
    try {
      var service = EventServiceApi();
      eventos = await service.getAllEvents();

      List<Marker> marcadores = [];
      for (var evento in eventos) {
        double latitud = evento.latitude;
        double longitud = evento.longitude;
        String eventType = evento.category;

        Color markerColor;
        switch (eventType) {
          case 'Evento peligroso':
            markerColor = const Color(0x00F24747);
            break;
          case 'Mala iluminación':
            markerColor = const Color(0x00f2ae47);
            break;
          case 'Reparación de vía':
            markerColor = const Color(0xFF52B0A5);
            break;
          default:
            markerColor = Colors.lightGreen.shade600;
            break;
        }

        var marcador = Marker(
          width: 300.0,
          height: 300.0,
          point: LatLng(latitud, longitud),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: markerColor,
            ),
            child: const Icon(
              Icons.location_on,
              size: 100,
              color: Colors.white,
            ),
          ),
        );

        marcadores.add(marcador);
      }

      setState(() {
        _eventMarkers = marcadores;
      });
    } catch (error) {
      print('Error al obtener eventos como marcadores: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: widget.currentLocation != null
            ? LatLng(
                widget.currentLocation!.latitude,
                widget.currentLocation!.longitude,
              )
            : widget.initialCenter,
        initialZoom: widget.initialZoom,
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(
            const LatLng(-90, -180),
            const LatLng(90, 180),
          ),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.safeway2.safeway2',
        ),
        CurrentLocationLayer(
          followOnLocationUpdate: FollowOnLocationUpdate.always,
          style: const LocationMarkerStyle(marker: DefaultLocationMarker()),
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: _eventMarkers,
            popupController: PopupController(),
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) {
                var evento = eventos.firstWhere((e) =>
                    e.latitude == marker.point.latitude &&
                    e.longitude == marker.point.longitude);

                return EventDetailOnMapScreen(eventId: evento.id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
