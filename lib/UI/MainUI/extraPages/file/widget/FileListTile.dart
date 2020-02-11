import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileRename.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/download/downloadSystem.dart';
import 'package:treex_app/network/NetworkDelete.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FileListTileWidget extends StatefulWidget {
  FileListTileWidget({
    Key key,
    @required this.file,
    @required this.onLongPress,
    @required this.onTap,
    this.share = true,
    @required this.callAfterOperation,
  }) : super(key: key);
  final NetFileEntity file;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final bool share;
  final VoidCallback callAfterOperation;
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
    final provider = Provider.of<AppProvider>(context);
    return SlideAnimation(
      horizontalOffset: 50,
      verticalOffset: 100,
      child: FadeInAnimation(
        delay: Duration(milliseconds: 100),
        child: ListTile(
          onLongPress: widget.onLongPress,
          onTap: () {
            if (widget.file.isDir) {
              widget.onTap();
            } else {
              //TODO when file suffix match,push to FileEx
              FileUtil.build(context).then((fileUtil) {
                OpenFile.open(fileUtil.appDir.path +
                    '/${provider.userProfile.name}/' +
                    widget.file.name);
              });
            }
          },
          contentPadding: edgeInsetsGeometryCurved(context),
          title: Text(
            widget.file.name,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          leading: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Hero(
                tag: widget.file.name,
                child: FileParseUtil.parseIcon(
                  name: widget.file.name,
                  isDir: widget.file.isDir,
                ),
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
                case 'rename':
                  showMIUIDialog(
                    context: context,
                    dyOffset: 0.5,
                    content: FileRenameWidget(
                      initText: widget.file.name,
                      isDir: widget.file.isDir,
                      share: widget.share,
                      path: widget.file.path,
                      onDone:(){
                        widget.callAfterOperation();
                      },
                    ),
                    label: 'rename',
                  );

                  break;
                case 'delete':
                  if (!widget.share) {
                    NetworkDelete(context).delete(widget.file.path);
                  }
                  widget.callAfterOperation();
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
