import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app/transferSystem/uploadFile.dart';

class TransferUploadListTileWidget extends StatefulWidget {
  TransferUploadListTileWidget({Key key,@required this.file}) : super(key: key);
  final UploadFile file;
  @override
  State<StatefulWidget> createState() => _TransferUploadListTileWidgetState();
}

class _TransferUploadListTileWidgetState
    extends State<TransferUploadListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(MaterialCommunityIcons.file_outline),
      ),
    );
  }
}
