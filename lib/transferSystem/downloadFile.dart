import 'package:dio/dio.dart';

class DownloadFile {
  double value;
  String name;
  CancelToken cancelToken;
  DownloadFile(this.name) {
    cancelToken = CancelToken();
  }
}

class MultiPartDownloadFile {
  int length;
  List<MultiSinglePart> parts;
  make(){
    //TODO make part
  }
}

class MultiSinglePart{

}
