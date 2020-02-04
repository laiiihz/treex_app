import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_app/UI/widget/transfer/TransferDownloadListTile.dart';
import 'package:treex_app/network/NetworkTestUtil.dart';

class TransferDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadState();
}

class _TransferDownloadState extends State<TransferDownloadPage> {
  double _value;
  @override
  void initState() {
    super.initState();
    Future test() async {
      await getExternalStorageDirectory().then((dir) {
        File fxxk;
        File(dir.path + '/1111.file').create().then((file) {
          fxxk = file;

        });
      });
    }

    test();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return TransferDownloadListTileWidget(
          value: _value,
        );
      },
      itemCount: 1,
    );
  }
}
