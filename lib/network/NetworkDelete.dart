import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkDelete extends NetworkUtilWithHeader {
  NetworkDelete(BuildContext context) : super(context);
  Future delete(String path) async {
    dio.delete('/api/treex/file/delete?path=$path');
  }
}
