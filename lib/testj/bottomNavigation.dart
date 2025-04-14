import 'package:flutter/material.dart';

class BottomNavCustom extends StatefulWidget {
  final ValueChanged<int> onTap;

  const BottomNavCustom({super.key, required this.onTap});

  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  int selectedIndex = 0;

  final List<NavigationItem> items = [
    NavigationItem(Icons.photo_library, 'Gallery', Color(0xff5B8C2D)),
    NavigationItem(Icons.camera, 'Camera', Color(0xff234520)),
    NavigationItem(Icons.notifications, 'Notifications', Color(0xff234520)),
  ];

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
        children: items.map((item) {
          final index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onTap(selectedIndex);
            },
            child: _buildItem(item, index == selectedIndex),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, color: isSelected ? item.color : Colors.grey),
        Text(
          item.title,
          style: TextStyle(
            color: isSelected ? item.color : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}
