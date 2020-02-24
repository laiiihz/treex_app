import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';

///network transfer @dio
///
/// dio put or post not working with Http2Adapter,so use the origin http/1.1
class NetworkTransferUtil {
  AppProvider provider;
  BuildContext context;
  Dio dio;
  NetworkTransferUtil(this.context) {
    this.provider = Provider.of<AppProvider>(context, listen: false);
    String https = provider.isHttps ? 'https' : 'http';
    String addr = provider.networkAddr;
    String port = (provider.networkPort as String).isEmpty
        ? '/'
        : ':${provider.networkPort}/';
    this.dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
        //TODO Self sign file check here
      };
    };
    this.dio
      ..options.headers = {
        'authorization': provider.token,
      }
      ..options.baseUrl = '$https://$addr$port';
  }
}
