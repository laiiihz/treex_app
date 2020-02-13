import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class UploadSystem {
  Future upload(BuildContext context,String path) async {
    await NetworkUtilWithHeader(context).dio.post('/api/treex/share');
  }
}
