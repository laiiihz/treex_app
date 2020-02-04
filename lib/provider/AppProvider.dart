import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treex_app/network/NetworkProfileUtil.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  get themeMode => _themeMode;
  setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool _haveCurved = false;
  get haveCurved => _haveCurved;
  setCurved(bool value) {
    _haveCurved = value;
    notifyListeners();
  }

  Color _primaryColor = Colors.blue;
  get primaryColor => _primaryColor;
  setPrimaryColor(Color color) {
    _primaryColor = color;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: color),
    );
    notifyListeners();
  }

  Color _secondaryColor = Colors.pinkAccent;
  get secondaryColor => _secondaryColor;
  setSecondaryColor(Color color) {
    _secondaryColor = color;
    notifyListeners();
  }

  bool _bottomBarColored = false;
  get bottomBarColored => _bottomBarColored;
  changeBottomBarColored(bool state) {
    _bottomBarColored = state;
    notifyListeners();
  }

  bool _iOSPlatform = false;
  get iOSPlatform => _iOSPlatform;
  changeIOSPlatform(bool platform) {
    _iOSPlatform = platform;
    notifyListeners();
  }

  bool _immersiveStatusBar = false;
  get immersiveStatusBar => _immersiveStatusBar;
  changeImmersiveStatusBar(bool status) {
    _immersiveStatusBar = status;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: status ? Colors.transparent : Colors.black26,
      systemNavigationBarColor: _primaryColor,
    ));
    notifyListeners();
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  get connectivityResult => _connectivityResult;
  setConnectivityResult(ConnectivityResult result) {
    _connectivityResult = result;
    print(_connectivityResult.toString() + "asd");
    notifyListeners();
  }

  bool _showFAB = true;
  get showFAB => _showFAB;
  changeFABDisplay(bool state) {
    _showFAB = state;
    notifyListeners();
  }

  bool _devTool = false;
  get devTool => _devTool;
  changeDevTool(bool state) {
    _devTool = state;
    notifyListeners();
  }

  bool _isHttps = true;
  get isHttps => _isHttps;
  changeHttpsStatus(bool state) {
    _isHttps = state;
    notifyListeners();
  }

  String _networkAddr = "";
  get networkAddr => _networkAddr;
  changeNetworkAddr(String addr) {
    _networkAddr = addr;
    notifyListeners();
  }

  String _networkPort = "";
  get networkPort => _networkPort;
  changeNetworkPort(String port) {
    _networkPort = port;
    notifyListeners();
  }

  String _token = "";
  get token => _token;
  setToken(String tokenStr) {
    _token = tokenStr;
    notifyListeners();
  }

  UserProfile _userProfile = UserProfile();
   UserProfile get userProfile => _userProfile;
  changeProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }
}
