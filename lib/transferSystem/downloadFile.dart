import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
  String name;
  String path;
  double value;
  CancelToken cancelToken;
  List<MultiSinglePart> parts;
  MultiPartDownloadFile({
    @required this.length,
    @required this.name,
    @required this.path,
    @required this.cancelToken,
  }) {}

  make() {
    //TODO make part
  }
}

class MultiSinglePart {}
