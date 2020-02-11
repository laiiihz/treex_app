import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkDelete extends NetworkUtilWithHeader {
  NetworkDelete(BuildContext context) : super(context);
  Future delete({
    String path,
    bool share = false,
  }) async {
    dio.delete('/api/treex/${share ? 'share' : 'file'}?path=$path');
  }

  Future clear() async {
    dio.delete('/api/treex/file/clear');
  }
}
