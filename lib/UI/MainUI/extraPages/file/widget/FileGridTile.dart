import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FileGridTileWidget extends StatefulWidget {
  FileGridTileWidget({Key key, @required this.file}) : super(key: key);
  final NetFileEntity file;
  @override
  State<StatefulWidget> createState() => _FileGridTileState();
}

class _FileGridTileState extends State<FileGridTileWidget> {
  bool _exist = false;
  String _path = '';
  @override
  void initState() {
    super.initState();
    FileUtil.build(context).then((fileUtil) {
      setState(() {
        _path = fileUtil.appDir.path;
        _exist = fileUtil.isExist(widget.file.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Card(
      shape: roundBorder10,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  FileParseUtil.parseIcon(
                    name: widget.file.name,
                    isDir: widget.file.isDir,
                  ),
                  _exist
                      ? Positioned(
                          right: -10,
                          bottom: -10,
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.file.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    Text('${FileParseUtil.parseDate(widget.file.date)}'),
                    Text(
                        '${widget.file.isDir ? '' : FileParseUtil.parseLength(widget.file.length)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
