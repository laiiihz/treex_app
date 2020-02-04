import 'package:flutter/material.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';

class FileListTileWidget extends StatefulWidget {
  FileListTileWidget({Key key, @required this.file, this.onLongPress})
      : super(key: key);
  final NetFileEntity file;
  final VoidCallback onLongPress;
  @override
  State<StatefulWidget> createState() => _FileListTileState();
}

class _FileListTileState extends State<FileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: widget.onLongPress,
      title: Text(
        widget.file.name,
        overflow: TextOverflow.fade,
      ),
      leading: Icon(FileParseUtil.parseIcon(
        name: widget.file.name,
        isDir: widget.file.isDir,
      )),
      subtitle: Text('${FileParseUtil.parseDate(widget.file.date)}'
          '${widget.file.isDir ? '' : '•'}'
          '${widget.file.isDir ? '' : FileParseUtil.parseLength(widget.file.length)}'),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(child: Text('test')),
          ];
        },
      ),
    );
  }
}
