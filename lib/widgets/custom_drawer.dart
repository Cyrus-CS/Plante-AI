import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemSelected;

  const CustomDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    double longeur = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Drawer(
        width: largeur / 1.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                radius: 50,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
            ),

            // Accueil
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Accueil'.tr()),
              onTap: () => onItemSelected(0),
            ),

            // Historiques
            ListTile(
              leading: const Icon(Icons.history),
              title: Text('historique'.tr()),
              onTap: () => onItemSelected(1),
            ),

            // Aide / À propos
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('A propos'.tr()),
              onTap: () => onItemSelected(2),
            ),

            // Paramètres
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: Text('Paramètres'.tr()),
              children: [
                // Thème
                SwitchListTile(
                  secondary: const Icon(Icons.brightness_6),
                  title: Text('thème'.tr()),
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (val) => themeProvider.toggleTheme(val),
                ),

                // Langue
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('language'.tr()),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Choisir une langue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Français"),
              onTap: () {
                context.setLocale(const Locale('fr'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("English"),
              onTap: () {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
