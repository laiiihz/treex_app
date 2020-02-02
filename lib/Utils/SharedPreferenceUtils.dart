import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_app/provider/AppProvider.dart';

class SharedBase {
  AppProvider provider;
  SharedBase(BuildContext context) {
    provider = Provider.of<AppProvider>(context, listen: false);
  }
}

///set and get value form SharedPreferences
class Shared extends SharedBase {
  Shared._(BuildContext context,SharedPreferences sharedPreferences) : super(context);
  SharedPreferences _sharedPreferences;
  static Future<Shared> init(BuildContext context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Shared._(context,sharedPreferences);
  }
  Future getShared() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future writeTransparent(bool value) async {
    await getShared();
    _sharedPreferences.setBool('transparent', value);
  }

  Future readTransparent() async {
    await getShared();
    provider.changeImmersiveStatusBar(
        _sharedPreferences.getBool('transparent') ?? false);
    print(provider.immersiveStatusBar);
  }

  Future writePrimaryColor(Color color) async {
    await getShared();
    _sharedPreferences.setInt('primaryColor', color.value);
  }

  Future readPrimaryColor() async {
    await getShared();
    provider.setPrimaryColor(Color(
        _sharedPreferences.getInt('primaryColor') ?? Colors.lightBlue.value));
  }

  Future writeSecondaryColor(Color color) async {
    await getShared();
    _sharedPreferences.setInt('secondaryColor', color.value);
  }

  Future readSecondaryColor() async {
    await getShared();
    provider.setSecondaryColor(Color(
        _sharedPreferences.getInt('secondaryColor') ?? Colors.pink.value));
  }

  Future writeThemeMode(ThemeMode themeMode) async {
    await getShared();
    int mode = themeMode2Int(themeMode);

    _sharedPreferences.setInt('themeMode', mode);
  }

  Future readThemeMode() async {
    await getShared();
    provider.setThemeMode(
        int2ThemeMode(_sharedPreferences.getInt('themeMode') ?? 0));
  }

  Future writeCurvedMode(bool curved) async {
    await getShared();
    _sharedPreferences.setBool('curved', curved);
  }

  Future readCurvedMode() async {
    await getShared();
    provider.setCurved(_sharedPreferences.getBool('curved') ?? false);
  }

  Future writeSlideBackMode(bool mode) async {
    await getShared();
    _sharedPreferences.setBool('slideBack', mode);
  }

  Future readSlideBackMode() async {
    await getShared();
    provider
        .changeIOSPlatform(_sharedPreferences.getBool('slideBack') ?? false);
  }

  Future writeColoredNavi(bool colored) async {
    await getShared();
    _sharedPreferences.setBool('NaviColored', colored);
  }

  Future readColoredNavi() async {
    await getShared();
    provider.changeBottomBarColored(
        _sharedPreferences.getBool('NaviColored') ?? false);
  }

  Future writeDevTools(bool state) async {
    await getShared();
    _sharedPreferences.setBool('devTool', state);
  }

  Future readDevTools() async {
    await getShared();
    provider.changeDevTool(_sharedPreferences.getBool('devTool') ?? false);
  }

  Future writeIsHttps(bool isHttps) async {
    await getShared();
    _sharedPreferences.setBool('https', isHttps);
  }
}

class Test {}

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
