import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkTransfer.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/uploadFile.dart';

class UploadSystem {
  Future upload({
    bool share = true,
    BuildContext context,
    String filePath,
  }) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    UploadFile uploadFile = UploadFile(FileUtil.getName(filePath));
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'path': share ? provider.nowSharePath : provider.nowAllFilesPath,
      'name': FileUtil.getName(filePath),
      'share': share,
    });
    //add task before upload
    provider.addUploadTask(uploadFile);
    NetworkTransferUtil(context).dio.post(
      '/api/treex/upload',
      data: formData,
      onSendProgress: (value, all) {
        provider.setUploadValue(value / all, provider.uploadTaskNumber - 1);
      },
    );
  }
}
