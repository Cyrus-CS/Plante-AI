import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Flutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://facebook.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://recherche-image-sur-le-net.com/background.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildDrawerItem(Icons.favorite, 'Favorite'),
          _buildDrawerItem(Icons.people, 'People'),
          _buildDrawerItem(Icons.share, 'Share'),
          _buildDrawerItem(Icons.notifications, 'Notifications'),
          _buildDrawerItem(Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
