import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkTransfer.dart';

class NetworkAvatar extends NetworkTransferUtil {
  NetworkAvatar(BuildContext context) : super(context);
  Future set(File file, String type) async {
    dio.post(
      '/api/treex/profile/avatar',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'type': type,
      }),
    );
  }
}
