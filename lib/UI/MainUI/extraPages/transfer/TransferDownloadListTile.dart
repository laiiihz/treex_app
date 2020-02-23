import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/ProfileGrid.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/downloadFile.dart';

class TransferDownloadListTileWidget extends StatefulWidget {
  TransferDownloadListTileWidget({
    Key key,
    this.downloadFile,
  }) : super(key: key);
  final MultiPartDownloadFile downloadFile;
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
        icon: Icon(widget.downloadFile.cancelToken.isCancelled
            ? Icons.play_arrow
            : Icons.pause),
        onPressed: () {
          widget.downloadFile.cancelToken.cancel("cancelled");
        },
      ),
      title: Text(widget.downloadFile.name),
      subtitle: LinearProgressIndicator(
        value: widget.downloadFile.value,
      ),
      contentPadding: edgeInsetsGeometryCurved(context),
      onTap: () {
        showMIUIDialog(
          context: context,
          dyOffset: 0.2,
          content: Container(
            height: 100,
            child: Row(
              children: <Widget>[
                ProfileGridWidget(
                  text: '删除该下载项',
                  icon: Icon(Icons.clear),
                  onTap: () {
                    final provider =
                        Provider.of<AppProvider>(context, listen: false);
                    widget.downloadFile.cancelToken.cancel();
                    provider.deleteDownloadTaskAt(widget.downloadFile);
                    //TODO delete local file
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          label: 'download',
        );
      },
    );
  }
}
