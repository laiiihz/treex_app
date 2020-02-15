import 'package:dio/dio.dart';

class UploadFile {
  String name;
  double value;
  CancelToken cancelToken;
  UploadFile(this.name) {
    this.cancelToken = CancelToken();
  }
}
