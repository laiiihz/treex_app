import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/NetworkNewFolder.dart';
import 'package:treex_app/provider/AppProvider.dart';

class NewFolderWidget extends StatefulWidget {
  NewFolderWidget({
    Key key,
    this.share = true,
  }) : super(key: key);
  final bool share;
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
    final provider = Provider.of<AppProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: '文件夹名称',
            hintText: '支持多级文件夹创建',
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
                path: widget.share
                    ? provider.nowSharePath
                    : provider.nowAllFilesPath,
                folderName: _textEditingController.text,
                share: widget.share,
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
