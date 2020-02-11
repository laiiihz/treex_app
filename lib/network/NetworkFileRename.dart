import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkFileRename extends NetworkUtilWithHeader {
  NetworkFileRename(BuildContext context) : super(context);
  Future rename({
    String path,
    String name,
  }) async {
    dio.put('/api/treex/file/rename?file=$path&new=$name');
  }
}
