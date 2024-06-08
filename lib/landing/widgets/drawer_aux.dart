import 'package:flutter/material.dart';
import 'package:safeway/landing/widgets/logout_button.dart';
import 'package:safeway/users/widgets/logo.dart';

class DrawerAux extends StatelessWidget {
  final bool isLoggedIn;
  final String? userName; // Nombre de usuario opcional

  const DrawerAux({
    super.key,
    required this.isLoggedIn,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(child: LogoSafeWay()),
                    if (isLoggedIn) // Solo mostrar si el usuario ha iniciado sesión
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, bottom: 5),
                        child: ListTile(
                          leading:
                              const Icon(Icons.person, color: Colors.white),
                          title: Text(
                            userName ?? 'Usuario',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          onTap: () {
                            // Acción al tocar esta opción
                            Navigator.pop(context);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text(
                'Notificaciones',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () {
                // Acción al tocar esta opción
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_available, color: Colors.white),
              title: const Text('Mis eventos',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onTap: () {
                // Navegar a la pantalla de registro de eventos
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EventRegisterScreen()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Ajustes',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onTap: () {
                // Acción al tocar esta opción
                Navigator.pop(context);
              },
            ), // Solo mostrar si el usuario ha iniciado sesión
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 280,
                  height: 50,
                  child: CustomLogOutButton(
                    isLogged: isLoggedIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
