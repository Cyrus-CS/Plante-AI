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
  int _selectedIndex = 1;

  final Color primaryColor = Color(0xFF234520);
  final Color secondaryColor = Color(0xFF5B8C2D);

  final List<Widget> _pages = [
    const HistoryPage(),       // Gallérie
    const PredictionPage(),    // Accueil
    const PredictionPage(),    // Photo
  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(onItemSelected: _onDrawerItemSelected),
      appBar: AppBar(
        title: const Text('PlantIA'),
        backgroundColor: primaryColor,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Accueil', index: 1),
              const SizedBox(width: 40), // pour le notch central
              _buildNavItem(icon: Icons.photo_sharp, label: 'Gallérie', index: 0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onBottomNavTapped(2),
        backgroundColor: _selectedIndex == 2 ? secondaryColor : Colors.grey.shade300,
        child: Icon(
          Icons.photo_camera,
          size: 30,
          color: _selectedIndex == 2 ? primaryColor : Colors.black54,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onBottomNavTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? primaryColor : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
