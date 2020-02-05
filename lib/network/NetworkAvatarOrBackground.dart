import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

enum FileTypeAB {
  AVATAR,
  BACKGROUND,
}

class NetworkAvatarOrBackground extends NetworkUtilWithHeader {
  NetworkAvatarOrBackground(BuildContext context) : super(context);
  Future build(String file, FileTypeAB type) async {
    String typeString;
    switch (type) {
      case FileTypeAB.AVATAR:
        typeString = 'avatar';
        break;
      case FileTypeAB.BACKGROUND:
        typeString = 'background';
        break;
    }
    FileUtil fileUtil = await FileUtil.build(context);
    await File('${fileUtil.appDir.path}/$file').create().then((file) {
      NetworkUtilWithHeader(context)
          .dio
          .download(
            '/api/treex/profile/$typeString',
            file.path,
          )
          .then((_) {
        switch (type) {
          case FileTypeAB.BACKGROUND:
            provider.changeBackgroundFile(
                fileUtil.getAvatarOrBackgroundFile(FileTypeAB.BACKGROUND));
            break;
          case FileTypeAB.AVATAR:
            provider.changeAvatarFile(
                fileUtil.getAvatarOrBackgroundFile(FileTypeAB.AVATAR));
            break;
        }
      });
    });
  }
}
