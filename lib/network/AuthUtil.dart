import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/Enums.dart';
import 'package:treex_app/provider/AppProvider.dart';

class NetworkUtil {
  AppProvider provider;
  Dio _dio;

  NetworkUtil(BuildContext context) {
    provider = Provider.of<AppProvider>(context, listen: false);
    bool https = provider.isHttps;
    String addr = provider.networkAddr;
    String port = (provider.networkPort as String).isEmpty
        ? '/'
        : ':${provider.networkPort}/';
    _dio = Dio()..options.baseUrl = 'http${https ? 's' : ''}://$addr$port/';
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
        //Self sign file check here
      };
    };
  }
}

class AuthUtil extends NetworkUtil {
  AuthUtil(BuildContext context) : super(context);
  Future<LoginResult> checkPassword(String name, String password) async {
    dynamic result = await _dio.get('/api/login?name=$name&password=$password');
    return loginResultMap[result.data['loginResult']['code']];
  }
}
