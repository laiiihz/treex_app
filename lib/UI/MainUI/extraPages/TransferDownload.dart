import 'package:flutter/material.dart';
import 'package:treex_app/UI/widget/transfer/TransferDownloadListTile.dart';

class TransferDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadState();
}

class _TransferDownloadState extends State<TransferDownloadPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return TransferDownloadListTileWidget();
      },
      itemCount: 1,
    );
  }
}
