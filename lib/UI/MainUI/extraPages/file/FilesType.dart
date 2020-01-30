import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class FilesTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesTypeState();
}

class _FilesTypeState extends State<FilesTypePage> {
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
              title: Text('文件类型'),
              background: LargeIconBackgroundWidget(
                tag: 'filesType',
                icon: Icons.category,
              ),
            ),
            expandedHeight: 200,
          ),
        ],
      ),
    );
  }
}
