import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/NetworkAvatarOrBackground.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FileUtil {
  AppProvider provider;
  Directory appDir;
  BuildContext context;
  FileUtil._(BuildContext context, Directory directory) {
    this.context = context;
    provider = Provider.of<AppProvider>(context, listen: false);
    appDir = directory;
  }
  static Future<FileUtil> build(BuildContext context) async {
    Directory dir = await getExternalStorageDirectory();
    return FileUtil._(context, dir);
  }

  File getAvatarOrBackgroundFile(FileTypeAB type) {
    switch (type) {
      case FileTypeAB.AVATAR:
        if (provider.userProfile.avatar.isEmpty) {
          return null;
        } else {
          return File('${appDir.path}/${provider.userProfile.avatar}');
        }
        break;
      case FileTypeAB.BACKGROUND:
        if (provider.userProfile.background.isEmpty) {
          return null;
        } else {
          return File('${appDir.path}/${provider.userProfile.background}');
        }
        break;
      default:
        return null;
        break;
    }
  }

  Future<File> getFile(String path, {bool share = false}) async {
    String prefix = appDir.path;
    String mid = share ? '/SHARE' : '/${provider.userProfile.name}';
    String pathFile = '/$path';
    return await File(prefix + mid + pathFile).create(recursive: true);
  }

  bool isExist(String path, {bool share = false}) {
    String prefix = appDir.path;
    String mid = share ? '/SHARE' : '/${provider.userProfile.name}';
    String pathFile = '/$path';
    return File(prefix + mid + pathFile).existsSync();
  }
}