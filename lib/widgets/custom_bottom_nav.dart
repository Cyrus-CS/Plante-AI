import 'package:flutter/material.dart';

import '../testj/history_page.dart';
import '../view/prediction_screen.dart';
import '../widgets/custom_drawer.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HistoryPage(), // Page pour le BottomNav index 0
    PredictionPage(), // Page pour le BottomNav index 1
    HistoryPage(), // Page pour le BottomNav index 2
  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Ferme le drawer
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Pas besoin de navigation ici, on met simplement à jour l'index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(onItemSelected: _onDrawerItemSelected),
      appBar: AppBar(title: const Text('Application')),
      body: _pages[
          _selectedIndex], // Affiche la page en fonction de l'index sélectionné
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Gallerie'),
        ],
      ),
    );
  }
}
