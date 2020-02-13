import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/provider/AppProvider.dart';

class NetworkUtilWithHeader {
  AppProvider provider;
  Dio dio;
  BuildContext context;

  NetworkUtilWithHeader(BuildContext context) {
    this.context = context;
    provider = Provider.of<AppProvider>(context, listen: false);
    bool https = provider.isHttps;
    String addr = provider.networkAddr;
    String port = (provider.networkPort as String).isEmpty
        ? '/'
        : ':${provider.networkPort}/';
    dio = Dio()
      ..httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: 500,
          onClientCreate: (_, clientSetting) =>
              clientSetting.onBadCertificate = (_) => true,
        ),
      )
      ..options.baseUrl = 'http${https ? 's' : ''}://$addr$port'
      ..options.headers = {'Authorization': provider.token};
  }
}

class NetFiles extends NetworkUtilWithHeader {
  NetFiles(BuildContext context) : super(context);
  Future<List<NetFileEntity>> files(
      {@required String path, bool share = true}) async {
    List<NetFileEntity> files = [];
    await dio
        .get('/api/treex/${share ? 'share' : 'file'}?path=$path')
        .then((value) {
      dynamic filesRaw = value.data['files'];
      String parentPath = value.data['parent'];
      String nowPath = value.data['path'];
      if (share) {
        provider.setShareParentPath(parentPath);
        provider.setSharePath(nowPath);
      } else {
        provider.setNowAllFilesParentPath(parentPath);
        provider.setNowFilesPath(nowPath);
      }
      for (dynamic item in filesRaw) {
        files.add(NetFileEntity.fromDynamic(item));
      }
    }).catchError((err) {
      print(err);
      return [];
    });
    return files;
  }

  Future<List<RecycleFileEntity>> recycleFiles() async {
    List<RecycleFileEntity> files = [];
    await dio.get('/api/treex/file/recycle').then((value) {
      dynamic raw = value.data;
      for (dynamic item in raw['recycleFiles']) {
        files.add(RecycleFileEntity.fromDynamic(item));
      }
    }).catchError((err) {
      print(err);
      return [];
    });
    return files;
  }

  Future<List<NetFileEntity>> search({@required String query}) async {
    List<NetFileEntity> files = [];
    await dio.get('/api/treex/file/search?query=$query').then((value) {
      dynamic raw = value.data;
      for (dynamic item in raw['search']) {
        files.add(NetFileEntity.fromDynamic(item));
      }
    }).catchError((err) {
      return [];
    });
    return files;
  }

  clearRecycle() async {
    await dio.delete('/api/treex/file/clear');
  }
}
