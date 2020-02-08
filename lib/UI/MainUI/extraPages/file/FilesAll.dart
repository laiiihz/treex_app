import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileListTile.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FilesAllPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesAllState();
}

class _FilesAllState extends State<FilesAllPage> {
  List<NetFileEntity> _files = [];
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    NetFiles(context)
        .files(path: provider.nowAllFilesPath, type: GetFilesType.PRIVATE)
        .then((files) => setState(() => _files = files));
  }

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
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: FileListTileWidget(
                      file: _files[index],
                      onLongPress: () {},
                      onTap: () {},
                      share: false,
                    ),
                  );
                },
                itemCount: _files.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
