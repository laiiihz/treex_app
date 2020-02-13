import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/download/downloadFile.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class DownloadSystem {
  Future download(BuildContext context, String path,
      {bool share = false}) async {
    FileUtil fileUtil = await FileUtil.build(context);
    File file = await fileUtil.getFile(path, share: share);
    int count = 0;
    fileUtil.provider.addTask(DownloadFile(path));
    await NetworkUtilWithHeader(context).dio.download(
      '/api/treex/${share ? 'share' : 'file'}/download?path=$path',
      file.path,
      onReceiveProgress: (value, all) {
        count++;
        if (count == 10) {
          fileUtil.provider
              .setDownloadValue(value / all, fileUtil.provider.taskNumber - 1);
          count = 0;
        }
        if (value == all) {
          fileUtil.provider
              .setDownloadValue(value / all, fileUtil.provider.taskNumber - 1);
        }
      },
    );
  }
}
