import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeway/landing/widgets/drawer_aux.dart';
import 'package:safeway/landing/widgets/floating_button.dart';
import 'package:safeway/global/globals_user.dart' as global;
import 'package:safeway/global/geolocator/geo_widget.dart';
import 'package:safeway/landing/widgets/map_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}

class _LandingScreenState extends State<LandingScreen> {
  LatLng _initialCenter = LatLng(-38.73965, -72.59842);
  double _initialZoom = 15;
  bool _loading = true;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Los permisos de ubicación están desactivados. Por favor active los permisos.')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Los permisos de ubicación están desactivados.')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Los permisos de ubicación están desactivados permanentemente, no se pueden solicitar permisos.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentPosition();
    setState(() {
      _loading = false;
    });
  }

  Future<void> _showEnableGPSDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Encender GPS'),
          content: const Text(
              'Por favor, encienda el GPS en la configuración del dispositivo para iniciar la aplicación.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Geolocator
                    .openAppSettings(); // Abre la configuración del dispositivo
              },
              child: const Text('Ir a configuración'),
            ),
          ],
        );
      },
    );
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
      drawer: const DrawerAux(),
      body: Stack(
        children: [
          MapWidget(
              initialCenter: _initialCenter,
              initialZoom: _initialZoom,
              currentLocation: _currentPosition),
          PositionedDirectional(
            start: 16,
            top: 16,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 6, 16, 24),
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.all(8),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: const AddEventFloatingButton(),
    );
  }
}
