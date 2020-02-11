import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app/network/NetworkNewFolder.dart';

class NewFolderWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewFolderState();
}

class _NewFolderState extends State<NewFolderWidget> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              MaterialCommunityIcons.folder,
              color: Colors.yellow,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RaisedButton(
            onPressed: () {
              NetworkNewFolder(context).folder(
                path: '.',
                folderName: _textEditingController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text('创建文件夹'),
          ),
        ),
      ],
    );
  }
}
