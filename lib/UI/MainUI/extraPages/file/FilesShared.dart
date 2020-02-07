import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/FileListTile.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class FilesSharedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesSharedState();
}

class _FilesSharedState extends State<FilesSharedPage> {
  List<NetFileEntity> files = [];
  ScrollController _scrollController = ScrollController();
  bool _isGridView = false;
  bool _showActions = false;
  bool _showSelectTool = false;
  Key _listKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    bool _lockDown = false;
    bool _lockUp = false;
    //action fade animation
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      //250 offset divide
      if (offset > 250) {
        _lockUp = false;
        if (!_lockDown) {
          setState(() => _showActions = true);
          _lockDown = true;
        } else {
          _lockDown = true;
        }
      } else {
        _lockDown = false;
        if (!_lockUp) {
          setState(() => _showActions = false);
          _lockUp = true;
        } else {
          _lockUp = true;
        }
      }
    });
    SharedFile(context).getSharedFile(path: '.').then((filesFetch) {
      setState(() {
        files = filesFetch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            physics: MIUIScrollPhysics(),
            slivers: <Widget>[
              //BUILD TOOLBAR
              SliverAppBar(
                pinned: true,
                stretch: true,
                floating: true,
                expandedHeight: 200,
                actions: <Widget>[
                  AnimatedOpacity(
                    opacity: _showActions ? 1 : 0,
                    duration: Duration(milliseconds: 350),
                    child: IconButton(
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
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('文件共享'),
                  background: LargeIconBackgroundWidget(
                      tag: 'share', icon: Icons.people),
                ),
              ),

              SliverToBoxAdapter(
                child: CardBarWidget(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(AntDesign.addfile),
                          onPressed: () {
                            FilePicker.getFile().then((file) {
                              print(file.path);
                            });
                          }),
                      VerticalDivider(
                        width: 2,
                        indent: 10,
                        endIndent: 10,
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
                  ),
                ),
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
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: FadeInAnimation(
            delay: Duration(milliseconds: 100),
            child: SlideAnimation(
              verticalOffset: 50,
              horizontalOffset: 50,
              delay: Duration(milliseconds: 100),
              child: Card(
                child: Text('test'),
              ),
            ),
          ),
        );
      },
      itemCount: files.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 400),
          child: SlideAnimation(
            horizontalOffset: 50,
            verticalOffset: 100,
            child: FadeInAnimation(
              delay: Duration(milliseconds: 100),
              child: FileListTileWidget(
                file: files[index],
                onLongPress: () {
                  setState(() {
                    _showSelectTool = true;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
