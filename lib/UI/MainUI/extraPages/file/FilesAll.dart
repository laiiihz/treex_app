import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class FilesAllPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesAllState();
}

class _FilesAllState extends State<FilesAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('文件管理'),
              background: LargeIconBackgroundWidget(
                tag: 'filesAll',
                icon: Icons.folder_open,
              ),
            ),
            expandedHeight: 200,
          ),

        ],
      ),
    );
  }
}
