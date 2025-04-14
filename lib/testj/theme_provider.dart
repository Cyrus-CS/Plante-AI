import 'package:flutter/material.dart';

// Déclaration d'un ValueNotifier pour le thème
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme(bool isDark) {
    _isDarkTheme = isDark;
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkTheme ? ThemeData.dark() : ThemeData.light();
}
