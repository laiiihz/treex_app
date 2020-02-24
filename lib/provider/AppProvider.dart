import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/network/NetworkProfileUtil.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';
import 'package:treex_app/transferSystem/uploadFile.dart';

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

  setUserPhone(String phone) {
    _userProfile.phone = phone;
    notifyListeners();
  }

  setUserEmail(String email) {
    _userProfile.email = email;
    notifyListeners();
  }

  File _avatarFile;
  File get avatarFile => _avatarFile;
  changeAvatarFile(File avatar) {
    _avatarFile = avatar;
    notifyListeners();
  }

  File _backgroundFile;
  File get backgroundFile => _backgroundFile;
  changeBackgroundFile(File background) {
    _backgroundFile = background;
    notifyListeners();
  }

  List<DownloadFile> _downloadFiles = [];
  List<DownloadFile> get downloadFiles => _downloadFiles;
  int get downloadTaskNumber => _downloadFiles.length;
  addTask(DownloadFile downloadFile) {
    _downloadFiles.add(downloadFile);
    notifyListeners();
  }

  setDownloadValue(double value, int index) {
    _downloadFiles[index].value = value;
    notifyListeners();
  }

  List<UploadFile> _uploadFiles = [];
  List<UploadFile> get uploadFiles => _uploadFiles;
  int get uploadTaskNumber => _uploadFiles.length;
  addUploadTask(UploadFile uploadFile) {
    _uploadFiles.add(uploadFile);
    notifyListeners();
  }

  setUploadValue(double value, int index) {
    _uploadFiles[index].value = value;
    notifyListeners();
  }

  String _nowShareParentPath;
  get nowShareParentPath => _nowShareParentPath;

  setShareParentPath(String path) {
    _nowShareParentPath = path;
    notifyListeners();
  }

  String _nowSharePath = '.';
  get nowSharePath => _nowSharePath;
  setSharePath(String path) {
    _nowSharePath = path;
    notifyListeners();
  }

  String _nowAllFilesParentPath;
  get nowAllFilesParentPath => _nowAllFilesParentPath;

  setNowAllFilesParentPath(String path) {
    _nowAllFilesParentPath = path;
    notifyListeners();
  }

  String _nowAllFilesPath = '.';
  get nowAllFilesPath => _nowAllFilesPath;
  setNowFilesPath(String path) {
    _nowAllFilesPath = path;
    notifyListeners();
  }

  bool _fastInit = false;
  get fastInit => _fastInit;
  setFastInit(bool state) {
    _fastInit = state;
    notifyListeners();
  }

  bool _vibrationIsOpen = true;
  get vibrationIsOpen => _vibrationIsOpen;
  setVibrationState(bool state) {
    _vibrationIsOpen = state;
    notifyListeners();
  }

  List<MultiPartDownloadFile> _downloadingFiles = [];
  List<MultiPartDownloadFile> get downloadingFiles => _downloadingFiles;
  addDownloadTask(MultiPartDownloadFile file) {
    _downloadingFiles.add(file);
    notifyListeners();
  }

  deleteDownloadTaskAt(MultiPartDownloadFile file) {
    _downloadingFiles.remove(file);
    notifyListeners();
  }

  setSingleFileDownloadValue(double value, int index) {
    _downloadingFiles[index].value = value;
    if (value == 1.0) {
      BotToast.showNotification(
        leading: (_) => FileParseUtil.parseIcon(
            name: _downloadingFiles[index].name, isDir: false),
        title: (_) => Text('下载完成'),
        subtitle: (_) => Text(
          _downloadingFiles[index].name,
          overflow: TextOverflow.fade,
        ),
      );
    }
    notifyListeners();
  }
}
