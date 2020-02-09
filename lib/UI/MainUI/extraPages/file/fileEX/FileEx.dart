import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';

class FileExPage extends StatefulWidget {
  FileExPage({Key key, @required this.file})
      : assert(file != null),
        super(key: key);
  final NetFileEntity file;
  @override
  State<StatefulWidget> createState() => _FileExState();
}

class _FileExState extends State<FileExPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
        ),
      ),
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(FileParseUtil.parseImg(widget.file.name).toString()),
              background: LargeIconBackgroundWidget(
                  tag: widget.file.name,
                  icon: FileParseUtil.parseIcon(
                    name: widget.file.name,
                    isDir: widget.file.isDir,
                  ).icon),
            ),
          ),
        ],
      ),
    );
  }
}
