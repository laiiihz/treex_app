import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/uploadFile.dart';

class UploadSystem {
  Future upload({
    bool share = false,
    BuildContext context,
    String path,
    String filePath,
  }) async {
    UploadFile uploadFile = UploadFile(path);
    FormData formData = FormData.fromMap({
      'name': FileUtil.getName(filePath),
      'file': MultipartFile.fromFile(filePath),
      'path': path,
    });
    final provider = Provider.of<AppProvider>(context, listen: false);
    await NetworkUtilWithHeader(context).dio.post(
      '/api/treex/share',
      cancelToken: uploadFile.cancelToken,
      data: formData,
      onSendProgress: (value, all) {
        provider.setUploadValue(value / all, provider.uploadFiles.length-1);
      },
    );
  }
}
