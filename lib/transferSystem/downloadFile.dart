import 'package:dio/dio.dart';

class DownloadFile {
  double value;
  String name;
  CancelToken cancelToken;
  DownloadFile(this.name) {
    cancelToken = CancelToken();
  }
}
