import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';

class DownloadSystem {
  Future download(BuildContext context, String path,
      {bool share = false}) async {
    FileUtil fileUtil = await FileUtil.build(context);
    File file = await fileUtil.getFile(path, share: share);
    DownloadFile downloadFile = DownloadFile(path);
    fileUtil.provider.addTask(downloadFile);
    await NetworkUtilWithHeader(context).dio.download(
      '/api/treex/${share ? 'share' : 'file'}/download?path=$path',
      file.path,
      onReceiveProgress: (value, all) {
        fileUtil.provider.setDownloadValue(
            value / all, fileUtil.provider.downloadTaskNumber - 1);
      },
      cancelToken: downloadFile.cancelToken,
    ).catchError((e) {
      if (downloadFile.cancelToken.isCancelled) {
        BotToast.showText(text: 'cancelled');
      }
    });
  }
}
