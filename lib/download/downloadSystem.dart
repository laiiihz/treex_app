import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/download/downloadFile.dart';
import 'package:treex_app/network/AuthUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

typedef void OnReceiveProgressCallBack(value, all);

class DownloadSystem {
  Future download(BuildContext context, String path,
      {bool share = false}) async {
    FileUtil fileUtil = await FileUtil.build(context);
    File file = await fileUtil.getFile(path, share: share);
    int count = 0;
    fileUtil.provider.addTask(DownloadFile());
    await NetworkUtilWithHeader(context).dio.download(
      '/api/treex/share/download?path=$path',
      file.path,
      onReceiveProgress: (value, all) {
        count++;
        if (count == 10) {
          fileUtil.provider
              .setDownloadValue(value / all, fileUtil.provider.taskNumber - 1);
          fileUtil.provider.changeValue(value / all);
          count = 0;
        }
        if (value == all) {
          fileUtil.provider
              .setDownloadValue(value / all, fileUtil.provider.taskNumber - 1);
          fileUtil.provider.changeValue(value / all);
        }
      },
    );
  }
}
