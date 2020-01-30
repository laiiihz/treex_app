import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';

/// get app brightness
bool isDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

ThemeMode getDarkMode(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return provider.themeMode;
}

setDarkMode(BuildContext context, ThemeMode mode) {
  final provider = Provider.of<AppProvider>(context, listen: false);
  provider.setThemeMode(mode);
}
