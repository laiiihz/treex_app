import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/UI/widget/file/FilesType.dart';

class FilesTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesTypeState();
}

class _FilesTypeState extends State<FilesTypePage> {
  int _currentExpand = -1;
  ScrollController _scrollController = ScrollController();
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 500), () {
      _scrollController.animateTo(
        100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
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
          SliverToBoxAdapter(
            child: ExpansionPanelList(
              expansionCallback: (index, value) {
                setState(() {
                  _currentExpand = (value ? -1 : index);
                });
              },
              children: [
                ExpansionPanel(
                  body: genFileType(['all', '照片', '视频', '音乐']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('媒体'),
                      leading: Icon(MaterialCommunityIcons.library_music),
                    );
                  },
                  isExpanded: _currentExpand == 0,
                  canTapOnHeader: true,
                ),
                ExpansionPanel(
                  body: genFileType(
                      ['all', 'doc', 'excel', 'ppt', 'pdf', 'markdown']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('文档'),
                      leading: Icon(MaterialCommunityIcons.file_document),
                    );
                  },
                  isExpanded: _currentExpand == 1,
                  canTapOnHeader: true,
                ),
                ExpansionPanel(
                  body: genFileType(['all', 'zip', 'rar', '7z']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('压缩包'),
                      leading: Icon(MaterialCommunityIcons.folder_zip),
                    );
                  },
                  isExpanded: _currentExpand == 2,
                  canTapOnHeader: true,
                ),
                ExpansionPanel(
                  body: genFileType(['all', 'exe', 'apk', 'dmg']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('安装包'),
                      leading: Icon(MaterialCommunityIcons.application),
                    );
                  },
                  isExpanded: _currentExpand == 3,
                  canTapOnHeader: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
