import 'package:flutter/material.dart';
import 'package:safeway/landing/screens/user_events.dart';
import 'package:safeway/landing/widgets/logout_button.dart';
import 'package:safeway/users/screens/login_screen.dart';
import 'package:safeway/users/widgets/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerAux extends StatefulWidget {
  const DrawerAux({super.key});

  @override
  _DrawerAuxState createState() => _DrawerAuxState();
}

class _DrawerAuxState extends State<DrawerAux> {
  bool isLoggedIn = false;
  String? userName;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('jwt_token') != null;
      userName = prefs.getString(
          'user_name'); // Asumiendo que guardas el nombre de usuario también
    });
  }

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
                    if (isLoggedIn)
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_available, color: Colors.white),
              title: const Text('Mis eventos',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onTap: () {
                if (isLoggedIn) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => MisEventosScreen()),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Ajustes',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
