import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../view/prediction_screen.dart';
import '../testj/history_page.dart';
import '../widgets/custom_drawer.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 1; // Page Accueil visible au démarrage
  int _activeIcon = 2;    // Icone "Photo" sélectionnée visuellement

  final Color primaryColor = const Color(0xFF234520);
  final Color secondaryColor = const Color(0xFF5B8C2D);

  final ImagePicker _picker = ImagePicker();

  final List<Widget> _pages = [
    const HistoryPage(),      // 0 = Gallérie (analyse galerie)
    const PredictionPage(),   // 1 = Accueil
    const PredictionPage(),   // 2 = Photo
  ];

  Future<void> _openCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PredictionPage(imagePath: picked.path),
        ),
      );
    }
  }

  Future<void> _openGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PredictionPage(imagePath: picked.path),
        ),
      );
    }
  }

  void _onNavTap(int index) async {
    setState(() {
      _activeIcon = index;
    });

    if (index == 0) {
      await _openGallery();
    } else if (index == 2) {
      await _openCamera();
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(onItemSelected: (i) {
        setState(() {
          _selectedIndex = i;
          _activeIcon = i;
        });
        Navigator.pop(context);
      }),
      appBar: AppBar(
        title: const Text('PlantIA'),
        backgroundColor: primaryColor,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.photo, label: "Gallérie", index: 0),
            _buildPhotoButton(),
            _buildNavItem(icon: Icons.home, label: "Accueil", index: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _activeIcon == index;

    return GestureDetector(
      onTap: () => _onNavTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? primaryColor : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoButton() {
    final bool isSelected = _activeIcon == 2;

    return GestureDetector(
      onTap: () => _onNavTap(2),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? secondaryColor.withOpacity(0.2) : Colors.transparent,
        ),
        child: Icon(
          Icons.photo_camera,
          size: 36,
          color: isSelected ? primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
