import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/transfer/TransferUploadListTile.dart';
import 'package:treex_app/provider/AppProvider.dart';

class TransferUploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferUploadState();
}

class _TransferUploadState extends State<TransferUploadPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return provider.uploadTaskNumber == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.inbox),
              Text('无上传任务'),
            ],
          )
        : ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return TransferUploadListTileWidget(
                file: provider.uploadFiles[index],
              );
            },
            itemCount: provider.uploadTaskNumber,
          );
  }
}
