import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileBackToolBar.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileGridTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileListTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/NewFolder.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/buildEmpty.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/network/NetworkNewFolder.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FilesAllPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesAllState();
}

class _FilesAllState extends State<FilesAllPage> {
  List<NetFileEntity> _files = [];
  bool _isGridView = false;
  Key _buildKey = UniqueKey();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    _getFiles(context: context, path: provider.nowAllFilesPath);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                shape: MIUIMenuShape,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(child: Text('新建文件夹'), value: 'new'),
                    PopupMenuItem(child: Text('上传文件'), value: 'upload'),
                    PopupMenuItem(child: Text('上传文件夹'), value: 'folders'),
                  ];
                },
                icon: Icon(MaterialCommunityIcons.cloud_upload),
                onSelected: (value) {
                  switch (value) {
                    case 'new':
                      showMIUIDialog(
                          context: context,
                          dyOffset: 0.5,
                          content: NewFolderWidget(),
                          label: 'test');
                  }
                },
              ),
              IconButton(
                icon: AnimatedCrossFade(
                  firstChild: Icon(Icons.view_list),
                  secondChild: Icon(Icons.view_module),
                  crossFadeState: _isGridView
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 350),
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                    _buildKey = UniqueKey();
                  });
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('文件管理'),
              background: LargeIconBackgroundWidget(
                tag: 'filesAll',
                icon: Icons.folder_open,
              ),
            ),
            expandedHeight: 200,
          ),
          FileBackToolBarWidget(
            showToolBar: provider.nowAllFilesParentPath != null,
            goBack: () {
              _getFiles(context: context, path: provider.nowAllFilesParentPath);
            },
            goRoot: () {
              _getFiles(context: context, path: '.');
            },
            nowPath: provider.nowAllFilesPath,
          ),
          buildEmpty(_files.length == 0),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: AnimationLimiter(
                key: _buildKey,
                child: _isGridView ? _buildGrid(context) : _buildList(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: FileListTileWidget(
            file: _files[index],
            onLongPress: () {},
            onTap: () {
              if (_files[index].isDir) {
                print(_files[index].path);
                _getFiles(context: context, path: _files[index].path);
              }
            },
            share: false,
          ),
        );
      },
      itemCount: _files.length,
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: FileGridTileWidget(
            file: _files[index],
          ),
        );
      },
      itemCount: _files.length,
    );
  }

  _getFiles({BuildContext context, String path}) {
    Future.delayed(Duration.zero, () {
      _scrollController.animateTo(
        -100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    });
    NetFiles(context).files(path: path, share: false).then((filesFetch) {
      setState(() {
        _files = filesFetch;
        _buildKey = UniqueKey();
      });
    });
  }
}
