import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/UI/widget/ProfileGrid.dart';

class FileViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileViewState();
}

class _FileViewState extends State<FileViewWidget> {
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: -500);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: MIUIScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          stretch: true,
          expandedHeight: 200,
          actions: <Widget>[
            Tooltip(
              message: '传输列表',
              child: RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(AntDesign.swap),
                  onPressed: () {
                    Navigator.of(context).pushNamed('transfer');
                  },
                ),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text('云盘'),
            background: LargeIconBackgroundWidget(
                tag: 'file_background', icon: Icons.cloud),
          ),
        ),
        SliverToBoxAdapter(
          child: CardBarWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ProfileGridWidget(
                  text: '共享',
                  icon: Hero(tag: 'share', child: Icon(Icons.people)),
                  onTap: () {
                    Navigator.of(context).pushNamed('filesShared');
                  },
                ),
                VerticalDivider(width: 2, indent: 10, endIndent: 10),
                ProfileGridWidget(
                  text: '文件',
                  icon: Hero(tag: 'filesAll', child: Icon(Icons.folder_open)),
                  onTap: () {
                    Navigator.of(context).pushNamed('filesAll');
                  },
                ),
                VerticalDivider(width: 2, indent: 10, endIndent: 10),
                ProfileGridWidget(
                  text: '类型',
                  icon: Hero(tag: 'filesType', child: Icon(Icons.category)),
                  onTap: () {
                    Navigator.of(context).pushNamed('filesType');
                  },
                ),
                VerticalDivider(width: 2, indent: 10, endIndent: 10),
                ProfileGridWidget(
                  text: '回收站',
                  icon: Hero(tag: 'recycle', child: Icon(Icons.delete_outline)),
                  onTap: () {
                    Navigator.of(context).pushNamed('recycle');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
