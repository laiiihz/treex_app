import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/Enums.dart';
import 'package:treex_app/provider/AppProvider.dart';

class NetworkUtil {
  AppProvider provider;
  Dio dio;

  NetworkUtil(BuildContext context) {
    provider = Provider.of<AppProvider>(context, listen: false);
    bool https = provider.isHttps;
    String addr = provider.networkAddr;
    String port = (provider.networkPort as String).isEmpty
        ? '/'
        : ':${provider.networkPort}/';
    dio = Dio()..options.baseUrl = 'http${https ? 's' : ''}://$addr$port/';
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
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
    dynamic result = await dio.get('/api/login?name=$name&password=$password');
    LoginResult _code = loginResultMap[result.data['loginResult']['code']];
    if (_code == LoginResult.SUCCESS) {
      provider.setToken(result.data['token']);
    }
    return _code;
  }

  Future<SignupResult> signup({
    String name,
    String password,
  }) async {
    Response response;
    await dio.put('/api/signup?name=$name&password=$password').then((value) {
      response = value;
    }).catchError((err) {
      print(err);
    });
    if (response == null) {
      return SignupResult.FAIL;
    } else {
      return signupResultMap[response.data['signupResult']['code']];
    }
  }
}
