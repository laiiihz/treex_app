import 'package:dio/adapter.dart';
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

enum GetFilesType {
  SHARED,
  PRIVATE,
}

Map<GetFilesType, String> _getFilesTypeMap = {
  GetFilesType.PRIVATE: 'file',
  GetFilesType.SHARED: 'share',
};

class NetFiles extends NetworkUtilWithHeader {
  NetFiles(BuildContext context) : super(context);
  Response response;
  Future<List<NetFileEntity>> files(
      {@required String path, @required GetFilesType type}) async {
    List<NetFileEntity> files = [];
    await dio
        .get('/api/treex/${_getFilesTypeMap[type]}?path=$path')
        .then((value) {
      response = value;
      dynamic filesRaw = response.data['files'];
      provider.setShareParentPath(response.data['parent']);
      provider.setSharePath(response.data['path']);
      for (dynamic item in filesRaw) {
        files.add(NetFileEntity.fromDynamic(item));
      }
    }).catchError((err) {
      print(err);
    });
    if (response == null) {
      return [];
    } else {
      return files;
    }
  }
}
