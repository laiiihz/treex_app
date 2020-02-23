import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/transfer/TransferDownloadListTile.dart';
import 'package:treex_app/provider/AppProvider.dart';

class TransferDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadState();
}

class _TransferDownloadState extends State<TransferDownloadPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return provider.downloadingFiles.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.inbox),
              Text('无下载任务'),
            ],
          )
        : ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return TransferDownloadListTileWidget(
                downloadFile: provider.downloadingFiles[index],
              );
            },
            itemCount: provider.downloadingFiles.length,
          );
  }
}
