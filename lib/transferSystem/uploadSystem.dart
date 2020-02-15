import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/transferSystem/uploadFile.dart';

class UploadSystem {
  Future upload(BuildContext context, String path, String filePath,
      {bool share = false}) async {
    UploadFile uploadFile = UploadFile(path);
    FormData formData = FormData.fromMap({
      "name": "testFile.png",
      "file": MultipartFile.fromFile(filePath),
      "path": ".",
    });
    await NetworkUtilWithHeader(context).dio.post(
          '/api/treex/share',
          cancelToken: uploadFile.cancelToken,
          data: formData,
        );
  }
}
