import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkNewFolder extends NetworkUtilWithHeader {
  NetworkNewFolder(BuildContext context) : super(context);
  Future folder({
    @required String folderName,
    @required String path,
    bool share = true,
  }) async {
    await dio.put("/api/treex/file/newFolder?folder=$folderName&path=$path");
  }
}
