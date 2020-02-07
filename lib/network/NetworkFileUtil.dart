import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
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
      ..options.baseUrl = 'http${https ? 's' : ''}://$addr$port/'
      ..options.headers = {'Authorization': provider.token};
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
        //Self sign file check here
      };
    };
  }
}

class SharedFile extends NetworkUtilWithHeader {
  SharedFile(BuildContext context) : super(context);
  Response response;
  Future<List<NetFileEntity>> getSharedFile({@required String path}) async {
    List<NetFileEntity> files = [];
    await dio.get('/api/treex/share?path=$path').then((value) {
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
