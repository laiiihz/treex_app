import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/network/NetworkFileRename.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FileRenameWidget extends StatefulWidget {
  FileRenameWidget({
    Key key,
    @required this.initText,
    this.isDir = true,
    this.share = true,
    this.path,
    this.onDone,
  }) : super(key: key);
  final String initText;
  final bool isDir;
  final bool share;
  final String path;
  final VoidCallback onDone;
  @override
  State<StatefulWidget> createState() => _FileRenameState();
}

class _FileRenameState extends State<FileRenameWidget> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initText;
  }

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
            prefixIcon: widget.isDir
                ? Icon(MaterialCommunityIcons.folder, color: Colors.yellow)
                : Icon(MaterialCommunityIcons.file, color: Colors.lightBlue),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RaisedButton(
            onPressed: () {
              NetworkFileRename(context)
                  .rename(
                path: widget.path,
                name: _textEditingController.text,
                share: widget.share,
              )
                  .then((_) {
                Future.delayed(Duration(milliseconds: 100), () {
                  widget.onDone();
                });
              });
              Navigator.of(context).pop();
            },
            child: Text('重命名'),
          ),
        )
      ],
    );
  }
}
