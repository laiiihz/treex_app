import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileBackToolBar.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileGridTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileListTile.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/NewFolder.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/buildEmpty.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/transferSystem/uploadSystem.dart';
import 'package:vibration/vibration.dart';

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
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(milliseconds: 500),
      () => _updateFiles(),
    );
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
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            child: CustomScrollView(
              controller: _scrollController,
              physics: MIUIScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  stretch: true,
                  floating: true,
                  snap: true,
                  expandedHeight: 200,
                  actions: <Widget>[
                    PopupMenuButton(
                      shape: MIUIMenuShape,
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(child: Text('新建文件夹'), value: 'new'),
                          PopupMenuItem(child: Text('上传文件'), value: 'upload'),
                          PopupMenuItem(
                              child: Text('上传文件夹'), value: 'uploadFolder'),
                        ];
                      },
                      onSelected: (value) {
                        switch (value) {
                          case 'new':
                            showMIUIDialog(
                              context: context,
                              dyOffset: 0.5,
                              label: 'newFolder',
                              content: NewFolderWidget(share: true),
                            );
                            break;
                          case 'upload':
                            FilePicker.getFilePath().then((path) {
                              UploadSystem().upload(
                                context: context,
                                filePath: path,
                              );
                            });
                            break;
                        }
                      },
                      icon: Icon(MaterialCommunityIcons.cloud_upload),
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
                FileBackToolBarWidget(
                  showToolBar: provider.nowShareParentPath != null,
                  goBack: () {
                    _getFiles(
                        context: context, path: provider.nowShareParentPath);
                  },
                  goRoot: () {
                    _getFiles(context: context, path: '.');
                  },
                  nowPath: provider.nowSharePath,
                ),
                buildEmpty(files.length == 0),
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
            onRefresh: () async {
              await _getFiles(context: context, path: provider.nowSharePath);
            },
            color: provider.primaryColor,
            backgroundColor: provider.secondaryColor,
          ),
          //SELECTION TOOLS
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
                _getFiles(context: context, path: files[index].path);
              }
            },
            callAfterOperation: () {
              final provider = Provider.of<AppProvider>(context, listen: false);
              _getFiles(context: context, path: provider.nowSharePath);
            },
          ),
        );
      },
    );
  }

  _updateFiles() {
    _scrollController.animateTo(
      -200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
    Vibration.vibrate(pattern: [0, 10, 250, 20]);
  }

  Future _getFiles({BuildContext context, String path}) async {
    await NetFiles(context).files(path: path).then((filesFetch) {
      setState(() {
        files = filesFetch;
        _listKey = UniqueKey();
      });
    }).then((_) {
      Vibration.vibrate(duration: 20);
    });
  }
}
