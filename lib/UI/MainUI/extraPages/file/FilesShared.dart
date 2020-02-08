import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileGridTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileListTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileToolBar.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FilesSharedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesSharedState();
}

class _FilesSharedState extends State<FilesSharedPage>
    with TickerProviderStateMixin {
  List<NetFileEntity> files = [];
  ScrollController _scrollController = ScrollController();
  bool _isGridView = false;
  bool _showSelectTool = false;
  Key _listKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    NetFiles(context)
        .files(
      path: provider.nowSharePath,
      type: GetFilesType.SHARED,
    )
        .then((filesFetch) {
      setState(() {
        files = filesFetch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            physics: MIUIScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                stretch: true,
                floating: true,
                snap: true,
                expandedHeight: 200,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(AntDesign.addfile),
                    onPressed: () {},
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
                    onPressed: () => setState(() {
                      _isGridView = !_isGridView;
                      _listKey = UniqueKey();
                    }),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('文件共享'),
                  background: LargeIconBackgroundWidget(
                      tag: 'share', icon: Icons.people),
                ),
              ),
              buildToolBar(
                context: context,
                showToolBar: provider.nowShareParentPath != null,
                goBack: () {
                  _scrollController.animateTo(
                    -100,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                  );
                  NetFiles(context)
                      .files(
                          path: provider.nowShareParentPath,
                          type: GetFilesType.SHARED)
                      .then((netFiles) {
                    setState(() {
                      files = netFiles;
                      _listKey = UniqueKey();
                    });
                  });
                },
                nowPath: provider.nowSharePath,
              ),
              _buildEmpty(),
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  child: AnimationLimiter(
                    key: _listKey,
                    child: _isGridView ? _buildGrid() : _buildList(),
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            curve: Curves.easeInOutCubic,
            top: _showSelectTool ? 0 : -100,
            right: 0,
            duration: Duration(milliseconds: 350),
            child: Container(
              height: 85,
              width: MediaQuery.of(context).size.width,
              child: Material(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          _showSelectTool = false;
                        });
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.select_all),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return SliverToBoxAdapter(
      child: files.length == 0
          ? Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.inbox,
                      size: 50,
                    ),
                    Text('空目录'),
                  ],
                ),
              ),
            )
          : SizedBox(height: 0),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: cardPaddingOuter(context),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: FileGridTileWidget(
            file: files[index],
          ),
        );
      },
      itemCount: files.length,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 400),
          child: FileListTileWidget(
            file: files[index],
            onLongPress: () {
              setState(() {
                _showSelectTool = true;
              });
            },
            onTap: () {
              if (files[index].isDir) {
                _scrollController.animateTo(
                  -50,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                );
                NetFiles(context)
                    .files(path: files[index].path, type: GetFilesType.SHARED)
                    .then((netFiles) {
                  setState(() {
                    files = netFiles;
                    _listKey = UniqueKey();
                  });
                });
              }
            },
          ),
        );
      },
    );
  }
}
