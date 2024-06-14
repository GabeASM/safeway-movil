import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';


class MapWidget extends StatefulWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final Position? currentLocation;

  MapWidget({
    required this.initialCenter,
    required this.initialZoom,
    required this.currentLocation,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> marcadores = [];
  List<Marker> _eventMarkers = [];
  /*Future<void> obtenerEventosAMarcadores() async {
    try {
      var eventos = await EventClient().getEvent();

      // Convierte la respuesta de la API en marcadores
      List<Marker> marcadores = [];
      for (var evento in eventos) {
        double latitud = evento['latitude'];
        double longitud = evento['longitude'];
        String eventType = evento['eventType'];

        // Asigna un color según el tipo de evento
        Color markerColor;
        switch (eventType) {
          case 'PELIGRO':
            markerColor = Colors.red;
            break;
          case 'ILUMINACION':
            markerColor = Colors.yellow;
            break;
          case 'REPARACIONES':
            markerColor = Colors.cyan.shade400;;
            break;
          default:
            markerColor =
                Colors.lightGreen.shade600; // Color por defecto para eventos desconocidos
            break;
        }

        // Crea un marcador para cada evento con el color asignado
        var marcador = Marker(
          width: 30.0,
          height: 30.0,
          point: LatLng(latitud, longitud),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: markerColor,
            ),
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
        );

        marcadores.add(marcador);
      }

      // Actualiza la lista de marcadores en el estado
      setState(() {
        _eventMarkers = marcadores;
      });
    } catch (error) {
      print('Error al obtener eventos como marcadores: $error');
    }
  }*/

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
          /*onPositionChanged: ( pos, bool hasGesture) {
          
          }*/
          ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.safeway2.safeway2',
        ),
        CurrentLocationLayer(
         alignDirectionOnUpdate: AlignOnUpdate.always,
          style: LocationMarkerStyle(marker: DefaultLocationMarker()),
        ),
        MarkerLayer(
          markers: _eventMarkers,
        )
      ],
    );
  }
}
