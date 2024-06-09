import 'package:flutter/material.dart';
import 'package:safeway/landing/widgets/drawer_aux.dart';
import 'package:safeway/landing/widgets/floating_button.dart';
import 'package:safeway/global/globals_user.dart' as global;

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (global.isLoggedIn) {}
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(),
        ),
        backgroundColor: const Color(0xFF121416),
      ),
      drawer: DrawerAux(
        isLoggedIn: global.isLoggedIn,
      ),
      body: const Center(child: Text('mapa')),
      floatingActionButton: const AddEventFloatingButton(),
    );
  }
}
