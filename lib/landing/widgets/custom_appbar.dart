import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PillClipper(),
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 80.0,
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: const Text('App '),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.0);
}

class PillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(0, 0, size.width / 2, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.height / 2);
    path.quadraticBezierTo(
        size.width, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
