import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkAvatarOrBackground extends NetworkUtilWithHeader {
  NetworkAvatarOrBackground(BuildContext context) : super(context);
  Future build(String file) async {
    FileUtil fileUtil = await FileUtil.build(context);
    await File('${fileUtil.appDir.path}/$file').create().then((file) {
      NetworkUtilWithHeader(context)
          .dio
          .download(
            '/api/treex/profile/avatar',
            file.path,
          )
          .then((_) {
        provider.changeAvatarFile(fileUtil.getAvatarFile());
      });
    });
  }
}
