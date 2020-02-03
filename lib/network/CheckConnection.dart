import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class CheckConnection {
  Dio _dio;

  CheckConnection({
    bool https,
    String addr,
    String port,
  }) {
    String portParsed = port.isEmpty ? '/' : ':$port/';
    _dio = Dio()
      ..options.baseUrl = 'http${https ? 's' : ''}://$addr$portParsed/';
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
        //Self sign file check here
      };
    };
  }
  Future<bool> check() async {
    Response _response;
    await _dio.get('/checkConnection').then((value) {
      _response = value;
    }).catchError((err) {
      print(err);
    });
    return _response == null
        ? false
        : _response.data['status'] == 200 ? true : false;
  }
}
