import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';

class CheckConnection {
  Dio _dio;

  CheckConnection({
    bool https,
    String addr,
    String port,
  }) {
    String portParsed = port.isEmpty ? '/' : ':$port/';
    _dio = Dio()
      ..httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: 500,
          onClientCreate: (_, clientSetting) =>
              clientSetting.onBadCertificate = (_) => true,
        ),
      )
      ..options.baseUrl = 'http${https ? 's' : ''}://$addr$portParsed';
  }
  Future<bool> check() async {
    Response _response;
    await _dio.get('/api/checkConnection').then((value) {
      _response = value;
    }).catchError((err) {
      print(err);
    });
    return _response == null
        ? false
        : _response.data['status'] == 200 ? true : false;
  }
}
