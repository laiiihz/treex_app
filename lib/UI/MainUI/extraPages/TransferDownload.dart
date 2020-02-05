import 'package:flutter/material.dart';
import 'package:treex_app/UI/widget/transfer/TransferDownloadListTile.dart';

class TransferDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadState();
}

class _TransferDownloadState extends State<TransferDownloadPage> {
  double _value;
  @override
  void initState() {
    super.initState();
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
