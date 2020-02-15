import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';

class TransferDownloadListTileWidget extends StatefulWidget {
  TransferDownloadListTileWidget({
    Key key,
    this.downloadFile,
  }) : super(key: key);
  final DownloadFile downloadFile;
  @override
  State<StatefulWidget> createState() => _TransferDownloadListTileState();
}

class _TransferDownloadListTileState
    extends State<TransferDownloadListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(MaterialCommunityIcons.file_outline),
      ),
      trailing: IconButton(
            icon: Icon(widget.downloadFile.cancelToken.isCancelled?Icons.play_arrow:Icons.pause),
            onPressed: () {
              widget.downloadFile.cancelToken.cancel("cancelled");
            },
          ),
      title: Text(widget.downloadFile.name),
      subtitle: LinearProgressIndicator(
        value: widget.downloadFile.value,
      ),
      contentPadding: edgeInsetsGeometryCurved(context),
      onLongPress: () {
        showMIUIDialog(
          context: context,
          dyOffset: 0.5,
          content: Container(
            height: 200,
          ),
          label: 'download',
        );
      },
    );
  }
}
