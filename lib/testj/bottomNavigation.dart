import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomNavCustom extends StatefulWidget {
  final ValueChanged<int> onTap;

  const BottomNavCustom({super.key, required this.onTap});

  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  int selectedIndex = 1; // Accueil au centre
  int notificationCount = 0;

  final Color primaryColor = Color(0xFF234520);
  final Color secondaryColor = Color(0xFF5B8C2D);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.photo_library, 'Gallery', 0),
          _buildItem(Icons.home, 'Accueil', 1),
          _buildItem(Icons.camera_alt, 'Photo', 2),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, int index) {
    Color color = selectedIndex == index ? primaryColor : Colors.grey;
    Widget iconWidget = Icon(icon, color: color);

    if (title == 'Notifications' && notificationCount > 0) {
      iconWidget = badges.Badge(
        badgeContent: Text(
          '$notificationCount',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        child: iconWidget,
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        widget.onTap(selectedIndex);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
