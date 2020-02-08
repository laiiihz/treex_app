import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/download/downloadSystem.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';

class FileListTileWidget extends StatefulWidget {
  FileListTileWidget({
    Key key,
    @required this.file,
    @required this.onLongPress,
    @required this.onTap,
    this.share = true,
  }) : super(key: key);
  final NetFileEntity file;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final bool share;
  @override
  State<StatefulWidget> createState() => _FileListTileState();
}

class _FileListTileState extends State<FileListTileWidget> {
  bool _exist = false;
  @override
  void initState() {
    super.initState();
    FileUtil.build(context).then((fileUtil) {
      setState(() {
        _exist = fileUtil.isExist(widget.file.path, share: widget.share);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      horizontalOffset: 50,
      verticalOffset: 100,
      child: FadeInAnimation(
        delay: Duration(milliseconds: 100),
        child: ListTile(
          onLongPress: widget.onLongPress,
          onTap: widget.onTap,
          contentPadding: edgeInsetsGeometryCurved(context),
          title: Text(
            widget.file.name,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          leading: Stack(
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
          subtitle: Text('${FileParseUtil.parseDate(widget.file.date)}'
              '${widget.file.isDir ? '' : '•'}'
              '${widget.file.isDir ? '' : FileParseUtil.parseLength(widget.file.length)}'),
          trailing: PopupMenuButton<String>(
            shape: MIUIMenuShape,
            itemBuilder: (BuildContext context) {
              return [
                widget.file.isDir
                    ? PopupMenuItem(
                        child: Text('批量下载'),
                        value: 'downloadAll',
                      )
                    : PopupMenuItem(
                        child: Text('${_exist ? '已' : ''}下载'),
                        value: 'download',
                        enabled: !_exist,
                      ),
                PopupMenuItem(
                  child: Text('重命名'),
                  value: 'rename',
                ),
                PopupMenuItem(
                  child: Text('删除', style: TextStyle(color: Colors.pink)),
                  value: 'delete',
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 'download':
                  DownloadSystem()
                      .download(context, widget.file.path, share: widget.share);
                  break;
                case 'downloadAll':
                  BotToast.showText(text: 'IN DEVELOPMENT❤');
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
