import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
class FileGridTileWidget extends StatefulWidget {
  FileGridTileWidget({Key key, @required this.file}) : super(key: key);
  final NetFileEntity file;
  @override
  State<StatefulWidget> createState() => _FileGridTileState();
}

class _FileGridTileState extends State<FileGridTileWidget> {
  bool _exist = false;
  @override
  void initState() {
    super.initState();
    FileUtil.build(context).then((fileUtil) {
      setState(() {
        _exist = fileUtil.isExist(widget.file.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: Duration(milliseconds: 50),
      child: SlideAnimation(
        verticalOffset: 100,
        delay: Duration(milliseconds: 50),
        child: Card(
          shape: roundBorder10,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Text(
                    widget.file.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
