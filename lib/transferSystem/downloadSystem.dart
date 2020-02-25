import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';



class DownloadSystemV2 {
  BuildContext context;
  DownloadSystemV2({@required this.context});
  MultiPartDownloadFile _multiPartDownloadFile;
  Future downloadV2({
    @required String path,
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
        '/api/treex/file/download?path=$path&share=$share',
        file.path,
        cancelToken: _multiPartDownloadFile.cancelToken,
        onReceiveProgress: (value, all) {
          provider.setSingleFileDownloadValue(value / all,
              provider.downloadingFiles.indexOf(_multiPartDownloadFile));
        },
      ).catchError((e) {
        if (_multiPartDownloadFile.cancelToken.isCancelled) {
          BotToast.showNotification(
            title: (_) => Text('下载被取消'),
            subtitle: (_) => Text(_multiPartDownloadFile.name),
          );
        }
      });
    } else {
      //multipart file
      _multipartsDownload() async {
        int partsCount = _multiPartDownloadFile.parts.length;
        FileUtil fileUtil = await FileUtil.build(context);
        NetworkUtilWithHeader _networkUtilWithHeader =
            NetworkUtilWithHeader(context);
        Map<String, dynamic> myheaders =
            _networkUtilWithHeader.dio.options.headers;
        for (int i = 0; i < partsCount; i++) {
          bool breakTag = false;
          int start = _multiPartDownloadFile.parts[i].start;
          int end = _multiPartDownloadFile.parts[i].end;
          File file = await fileUtil.getFile(path + '.$i', share: share);
          Dio dio = _networkUtilWithHeader.dio;
          dio.options.headers = myheaders;
          dio.options.headers
              .addEntries([MapEntry('Range', 'bytes=$start-$end')]);
          print(context.hashCode);
          await dio.download(
            '/api/treex/file/download?path=$path&share=$share',
            file.path,
            cancelToken: _multiPartDownloadFile.cancelToken,
            onReceiveProgress: (value, all) {
              provider.setSingleFileDownloadValue(
                (value + FILESIZE.serverMaxSize * i) /
                    _multiPartDownloadFile.length,
                provider.downloadingFiles.indexOf(_multiPartDownloadFile),
              );
            },
          ).catchError((e) {
            if (_multiPartDownloadFile.cancelToken.isCancelled) {
              BotToast.showNotification(
                title: (_) => Text('下载被取消'),
                subtitle: (_) => Text(_multiPartDownloadFile.name),
              );
            }
          }).whenComplete(() {
            if (_multiPartDownloadFile.cancelToken.isCancelled) {
              breakTag = true;
            }
          });
          if (breakTag) break;
        }
      }

      _multipartsDownload().then((_) {
        print("download done");
      });
    }
  }

  Future<bool> downloadInit({
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
    if (endTag) return false;
    Dio dio = networkUtilWithHeader.dio;
    dio.options.headers.addEntries([MapEntry('Range', 'bytes=0-0')]);
    await dio
        .get('/api/treex/file/download?path=$path&share=$share')
        .then((response) {
      String rawRange = response.headers['content-range'][0];
      _multiPartDownloadFile = MultiPartDownloadFile(
        length: _parseRange(rawRange),
        name: _path2Name(path),
        cancelToken: CancelToken(),
        path: path,
      );
      print(_multiPartDownloadFile.cancelToken.hashCode);
      networkUtilWithHeader.provider.addDownloadTask(_multiPartDownloadFile);
      BotToast.showNotification(title: (_) => Text('创建下载任务成功'));
    });
    return true;
  }

  int _parseRange(String rawRange) {
    return int.parse(rawRange.split('/')[1]);
  }

  String _path2Name(String path) {
    return path.substring(path.lastIndexOf('/') + 1);
  }
}
