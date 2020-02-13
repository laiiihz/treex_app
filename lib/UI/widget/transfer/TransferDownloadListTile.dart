import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';

class TransferDownloadListTileWidget extends StatefulWidget {
  TransferDownloadListTileWidget({
    Key key,
    this.value,
    this.name,
  }) : super(key: key);
  final double value;
  final String name;
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {},
          ),
        ],
      ),
      title: Text(widget.name),
      subtitle: LinearProgressIndicator(
        value: widget.value,
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
