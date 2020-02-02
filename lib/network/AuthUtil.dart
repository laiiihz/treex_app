import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/Enums.dart';
import 'package:treex_app/provider/AppProvider.dart';

class AuthUtil {
  AppProvider provider ;
  Dio _dio = Dio();
  AuthUtil(BuildContext context) {
  provider =Provider.of<AppProvider>(context,listen: false);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  }

  Future<LoginResult> checkPassword(String name,String password) async {
    dynamic result = await _dio
        .get('https://192.168.31.130/api/login?name=$name&password=$password');
    return loginResultMap[result.data['loginResult']['code']];
  }

  getTest() async {
    await _dio.get('https://192.168.31.130/test').then((value) {
      print(value.data);
    });
  }
}
