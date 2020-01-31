import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_app/provider/AppProvider.dart';

///set and get value form SharedPreferences
class Shared {
  static SharedPreferences _sharedPreferences;
  static Future getShared() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future writeTransparent(bool value) async {
    await getShared();
    _sharedPreferences.setBool('transparent', value);
  }

  static Future readTransparent(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.changeImmersiveStatusBar(
        _sharedPreferences.getBool('transparent') ?? false);
    print(provider.immersiveStatusBar);
  }

  static Future writePrimaryColor(Color color) async {
    await getShared();
    _sharedPreferences.setInt('primaryColor', color.value);
  }

  static Future readPrimaryColor(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.setPrimaryColor(Color(
        _sharedPreferences.getInt('primaryColor') ?? Colors.lightBlue.value));
  }

  static Future writeSecondaryColor(Color color) async {
    await getShared();
    _sharedPreferences.setInt('secondaryColor', color.value);
  }

  static Future readSecondaryColor(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.setSecondaryColor(Color(
        _sharedPreferences.getInt('secondaryColor') ?? Colors.pink.value));
  }

  static Future writeThemeMode(ThemeMode themeMode) async {
    await getShared();
    int mode = themeMode2Int(themeMode);

    _sharedPreferences.setInt('themeMode', mode);
  }

  static Future readThemeMode(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.setThemeMode(
        int2ThemeMode(_sharedPreferences.getInt('themeMode') ?? 0));
  }

  static Future writeCurvedMode(bool curved) async {
    await getShared();
    _sharedPreferences.setBool('curved', curved);
  }

  static Future readCurvedMode(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.setCurved(_sharedPreferences.getBool('curved') ?? false);
  }

  static Future writeSlideBackMode(bool mode) async {
    await getShared();
    _sharedPreferences.setBool('slideBack', mode);
  }

  static Future readSlideBackMode(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider
        .changeIOSPlatform(_sharedPreferences.getBool('slideBack') ?? false);
  }

  static Future writeColoredNavi(bool colored) async {
    await getShared();
    _sharedPreferences.setBool('NaviColored', colored);
  }

  static Future readColoredNavi(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.changeBottomBarColored(
        _sharedPreferences.getBool('NaviColored') ?? false);
  }

  static Future writeDevTools(bool state) async {
    await getShared();
    _sharedPreferences.setBool('devTool', state);
  }

  static Future readDevTools(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await getShared();
    provider.changeDevTool(_sharedPreferences.getBool('devTool') ?? false);
  }
}

///system 0
///
///lightMode 1
///
///darkMode 2
int themeMode2Int(ThemeMode themeMode) {
  Map<ThemeMode, int> themeModeMap = {
    ThemeMode.system: 0,
    ThemeMode.light: 1,
    ThemeMode.dark: 2,
  };

  return themeModeMap[themeMode];
}

///0 system
///
///1 lightMode
///
///2 darkMode
ThemeMode int2ThemeMode(int mode) {
  Map<int, ThemeMode> themeModeMap = {
    0: ThemeMode.system,
    1: ThemeMode.light,
    2: ThemeMode.dark,
  };
  return themeModeMap[mode];
}
