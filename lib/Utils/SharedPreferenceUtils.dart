import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_app/provider/AppProvider.dart';

class SharedBase {
  AppProvider provider;
  SharedPreferences _sharedPreferences;
  SharedBase(BuildContext context, SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
    provider = Provider.of<AppProvider>(context, listen: false);
  }
}

///set and get value form SharedPreferences
class Shared extends SharedBase {
  Shared._(BuildContext context, SharedPreferences sharedPreferences)
      : super(context, sharedPreferences);

  static Future<Shared> init(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Shared._(context, sharedPreferences);
  }

  Future writeTransparent(bool value) async {
    _sharedPreferences.setBool('transparent', value);
  }

  Future readTransparent() async {
    provider.changeImmersiveStatusBar(
        _sharedPreferences.getBool('transparent') ?? false);
    print(provider.immersiveStatusBar);
  }

  Future writePrimaryColor(Color color) async {
    _sharedPreferences.setInt('primaryColor', color.value);
  }

  Future readPrimaryColor() async {
    provider.setPrimaryColor(Color(
        _sharedPreferences.getInt('primaryColor') ?? Colors.lightBlue.value));
  }

  Future writeSecondaryColor(Color color) async {
    _sharedPreferences.setInt('secondaryColor', color.value);
  }

  Future readSecondaryColor() async {
    provider.setSecondaryColor(Color(
        _sharedPreferences.getInt('secondaryColor') ?? Colors.pink.value));
  }

  Future writeThemeMode(ThemeMode themeMode) async {
    int mode = themeMode2Int(themeMode);

    _sharedPreferences.setInt('themeMode', mode);
  }

  Future readThemeMode() async {
    provider.setThemeMode(
        int2ThemeMode(_sharedPreferences.getInt('themeMode') ?? 0));
  }

  Future writeCurvedMode(bool curved) async {
    _sharedPreferences.setBool('curved', curved);
  }

  Future readCurvedMode() async {
    provider.setCurved(_sharedPreferences.getBool('curved') ?? false);
  }

  Future writeSlideBackMode(bool mode) async {
    _sharedPreferences.setBool('slideBack', mode);
  }

  Future readSlideBackMode() async {
    provider
        .changeIOSPlatform(_sharedPreferences.getBool('slideBack') ?? false);
  }

  Future writeColoredNavi(bool colored) async {
    _sharedPreferences.setBool('NaviColored', colored);
  }

  Future readColoredNavi() async {
    provider.changeBottomBarColored(
        _sharedPreferences.getBool('NaviColored') ?? false);
  }

  Future writeDevTools(bool state) async {
    _sharedPreferences.setBool('devTool', state);
  }

  Future readDevTools() async {
    provider.changeDevTool(_sharedPreferences.getBool('devTool') ?? false);
  }

  Future writeIsHttps(bool isHttps) async {
    _sharedPreferences.setBool('https', isHttps);
  }

  Future readIsHttps() async {
    provider.changeHttpsStatus(_sharedPreferences.getBool('https') ?? true);
  }

  Future writeNetworkAddr(String addr) async {
    _sharedPreferences.setString('networkAddr', addr);
  }

  Future readNetworkAddr() async {
    provider.changeNetworkAddr(
        _sharedPreferences.getString('networkAddr') ?? '127.0.0.1');
  }

  Future writeNetworkPort(String port) async {
    _sharedPreferences.setString('networkPort', port);
  }

  Future readNetworkPort() async {
    provider
        .changeNetworkPort(_sharedPreferences.getString('networkPort') ?? '');
  }

  Future writeToken(String token) async {
    _sharedPreferences.setString('token', token);
  }

  Future readToken() async {
    provider.setToken(_sharedPreferences.getString('token') ?? '');
  }

  Future writeVibrationState(bool state) async {
    _sharedPreferences.setBool('vibration', state);
  }

  Future readVibrationState() async {
    provider.setVibrationState(_sharedPreferences.getBool('vibration') ?? true);
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
