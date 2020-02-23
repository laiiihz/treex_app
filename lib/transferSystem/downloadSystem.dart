import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';

class DownloadSystem {
  Future download(
    BuildContext context,
    String path, {
    bool share = false,
  }) async {
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

class DownloadSystemV2 {
  BuildContext context;
  DownloadSystemV2({this.context});
  MultiPartDownloadFile _multiPartDownloadFile;
  Future downloadV2({
    String path,
    bool share = false,
  }) async {
    NetworkUtilWithHeader networkUtilWithHeader =
        NetworkUtilWithHeader(context);
    AppProvider provider = networkUtilWithHeader.provider;
    final nowFile = provider.downloadingFiles[
        provider.downloadingFiles.indexOf(_multiPartDownloadFile)];
    if (nowFile.single) {
      //single file download
      FileUtil fileUtil = await FileUtil.build(context);
      File file = await fileUtil.getFile(path, share: share);
      networkUtilWithHeader.dio.download(
        '/api/treex/${share ? 'share' : 'file'}/download?path=$path',
        file.path,
        onReceiveProgress: (value, all) {
          provider.setSingleFileDownloadValue(value / all,
              provider.downloadingFiles.indexOf(_multiPartDownloadFile));
        },
      );
    } else {
      //multipart file
    }
  }

  Future downloadInit({
    @required String path,
    bool share = false,
  }) async {
    NetworkUtilWithHeader networkUtilWithHeader =
        NetworkUtilWithHeader(context);
    AppProvider provider = networkUtilWithHeader.provider;
    bool endTag = false;
    provider.downloadingFiles.forEach((multiFile) {
      //check file is downloading
      if (multiFile.path == path) {
        BotToast.showNotification(
          title: (_) => Text('已在下载'),
        );
        endTag = true;
      }
    });
    if (endTag) return;
    Dio dio = networkUtilWithHeader.dio;
    dio.options.headers.addEntries([MapEntry('Range', 'bytes=0-0')]);
    await dio.get('/api/treex/file/download?path=$path').then((response) {
      String rawRange = response.headers['content-range'][0];
      _multiPartDownloadFile = MultiPartDownloadFile(
        length: _parseRange(rawRange),
        name: 'ph1oto.ps1',
        cancelToken: CancelToken(),
        path: path,
      );

      networkUtilWithHeader.provider.addDownloadTask(_multiPartDownloadFile);
      BotToast.showNotification(title: (_) => Text('创建下载任务成功'));
    });
  }

  int _parseRange(String rawRange) {
    return int.parse(rawRange.split('/')[1]);
  }
}
