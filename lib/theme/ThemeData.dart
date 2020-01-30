import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';

ThemeData lightTheme(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return ThemeData(
    platform:
        provider.iOSPlatform ? TargetPlatform.iOS : TargetPlatform.android,
    primaryColor: provider.primaryColor,
    toggleableActiveColor: provider.primaryColor,
    buttonColor: provider.primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: provider.secondaryColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      buttonColor: provider.primaryColor,
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return ThemeData.dark().copyWith(
    platform:
        provider.iOSPlatform ? TargetPlatform.iOS : TargetPlatform.android,
    toggleableActiveColor: provider.primaryColor,
    primaryColor: provider.primaryColor,
    buttonColor: provider.primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: provider.secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: provider.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: provider.primaryColor,width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: provider.primaryColor, width: 3),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      buttonColor: provider.primaryColor,
    ),
  );
}
