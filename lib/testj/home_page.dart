import 'package:plant_disease/testj/history_page.dart';
import 'package:plant_disease/view/prediction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottomNavigation.dart';
import 'sidebar_with_animation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _selectedIndex = 0;

  final List<Widget> _bottomNavPages = [
    HistoryPage(), // Page pour le BottomNav index 0
    PredictionPage(), // Page pour le BottomNav index 1
    HistoryPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  int _selectedIndex = 0;
  int _selectedBottomNavIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Home Page'),
          ],
        ),
      ),
    ),
    Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Insights Page'),
          ],
        ),
      ),
    ),
    Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Feature Page'),
          ],
        ),
      ),
    ),
    Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Payouts Page'),
          ],
        ),
      ),
    ),
    Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Settings Page'),
          ],
        ),
      ),
    ),
  ];

  // Fonction pour gérer le changement d'index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Met à jour l'index de la page sélectionnée
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBarAnimated(
            unselectedIconColor: Colors.white,
            selectedIconColor: Colors.black,
            onTap: _onItemTapped,
            sideBarColor: Colors.teal,
            animatedContainerColor: Colors.black,
            widthSwitch: 700,
            mainLogoImage: 'assets/images/logo.png',
            sidebarItems: [
              SideBarItem(
                iconSelected: Icons.home_rounded,
                iconUnselected: Icons.home_outlined,
                text: 'Home',
              ),
              SideBarItem(
                iconSelected: Icons.account_balance_wallet,
                iconUnselected: Icons.account_balance_wallet_outlined,
                text: 'Insights',
              ),
              SideBarItem(
                iconSelected: CupertinoIcons.chart_bar_square_fill,
                iconUnselected: CupertinoIcons.chart_bar_square,
                text: 'Feature',
              ),
              SideBarItem(
                iconSelected: Icons.credit_card_rounded,
                text: 'Payouts',
              ),
              SideBarItem(
                iconSelected: Icons.settings,
                iconUnselected: Icons.settings_outlined,
                text: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: _selectedIndex > 0
                ? _pages[
                    _selectedIndex] // Afficher les pages du SideBar si un index > 0 est sélectionné
                : _bottomNavPages[
                    _selectedBottomNavIndex], // Sinon afficher les pages du BottomNav
          ),
        ],
      ),
      bottomNavigationBar: BottomNavCustom(
        onTap: _onBottomNavTapped, // Gestion de la sélection du BottomNav
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Home Page'),
          ],
        ),
      ),
    );
  }
}

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Insights Page'),
          ],
        ),
      ),
    );
  }
}

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Feature Page'),
          ],
        ),
      ),
    );
  }
}

class PayoutsPage extends StatelessWidget {
  const PayoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Payouts Page'),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 10),
            const Text('Welcome to Settings Page'),
          ],
        ),
      ),
    );
  }
}
