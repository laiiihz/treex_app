import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/transfer/TransferDownloadListTile.dart';
import 'package:treex_app/provider/AppProvider.dart';

class TransferDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadState();
}

class _TransferDownloadState extends State<TransferDownloadPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return ListView.builder(
      physics: MIUIScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TransferDownloadListTileWidget(
          value: provider.downloadFiles[index].value,
          name: provider.downloadFiles[index].name,
        );
      },
      itemCount: provider.taskNumber,
    );
  }
}
