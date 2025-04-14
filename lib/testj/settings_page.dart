// settings_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = themeNotifier.value == ThemeMode.dark;
  String currentLanguage = 'en'; // Par défaut : anglais

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text(isDarkTheme ? 'Dark Theme'.tr() : 'Light Theme'.tr()),
              value: isDarkTheme,
              onChanged: (value) {
                setState(() {
                  isDarkTheme = value;
                  themeNotifier.value = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
                });
              },
            ),
            Divider(),
            Text(
              'Language'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: currentLanguage,
              onChanged: (String? newLanguage) {
                if (newLanguage != null) {
                  setState(() {
                    currentLanguage = newLanguage;
                    // Mise à jour de la langue
                    context.setLocale(Locale(newLanguage));
                  });
                }
              },
              items: ['en', 'fr'].map<DropdownMenuItem<String>>((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(
                    language == 'en' ? 'English' : 'French',
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
