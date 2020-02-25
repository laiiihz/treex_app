import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///init MultiPartDownloadFile
///
///split file when file larger than 40MB(default)
class MultiPartDownloadFile {
  int length;
  String name;
  String path;
  double value;
  CancelToken cancelToken;
  int partLength;
  bool single = false;
  List<MultiSinglePart> parts = [];
  MultiPartDownloadFile({
    @required this.length,
    @required this.name,
    @required this.path,
    @required this.cancelToken,
  }) {
    if (length < FILESIZE.serverMaxSize) {
      single = true;
      parts.add(MultiSinglePart(start: 0, end: length));
    } else {
      int startCursor = 0;
      int endCursor = startCursor + FILESIZE.serverMaxSize - 1;
      //prefix part
      while (endCursor < length) {
        parts.add(MultiSinglePart(start: startCursor, end: endCursor));
        startCursor += FILESIZE.serverMaxSize;
        endCursor = startCursor + FILESIZE.serverMaxSize - 1;
      }
      //last part
      parts.add(MultiSinglePart(start: startCursor, end: length));
    }
  }

  make() {
    //TODO make part
  }
}

class MultiSinglePart {
  int start = 0;
  int end = 0;
  MultiSinglePart({this.start, this.end});
}

class FILESIZE {
  static int fsB = 1;
  static int fsKB = 1024;
  static int fsMB = 1024 * 1024;
  static int fsGB = 1024 * 1024 * 1024;
  static int serverMaxSize = fsMB * 40;
}
