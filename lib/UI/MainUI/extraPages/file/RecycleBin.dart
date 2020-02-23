import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:vibration/vibration.dart';

class RecycleBinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBinPage> {
  ScrollController _scrollController = ScrollController();
  List<RecycleFileEntity> _files = [];
  Timer timer;
  Key _listKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(milliseconds: 300), () => _updateRecycleBin());
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: RefreshIndicator(
        child: CustomScrollView(
          controller: _scrollController,
          physics: MIUIScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              stretch: true,
              floating: true,
              actions: <Widget>[
                Tooltip(
                  message: '清空文件',
                  child: IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      NetFiles(context).clearRecycle();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                PopupMenuButton<String>(
                  shape: MIUIMenuShape,
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text('自动删除时间设置'),
                        value: 'autoDelete',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 'autoDelete':
                        showMIUIConfirmDialog(
                          context: context,
                          title: '自动删除时间设置',
                          child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              itemExtent: 30,
                              looping: true,
                              onSelectedItemChanged: (value) {
                                print(value);
                                Vibration.vibrate(duration: 5);
                              },
                              children: [
                                Text('5天'),
                                Text('10天'),
                                Text('15天'),
                                Text('20天'),
                                Text('25天'),
                                Text('30天'),
                              ],
                            ),
                          ),
                          confirm: () {},
                        );
                        break;
                    }
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text('回收站'),
                background: LargeIconBackgroundWidget(
                  tag: 'recycle',
                  icon: Icons.delete_outline,
                ),
              ),
              expandedHeight: 200,
            ),
            SliverList(
              key: _listKey,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: 50,
                      verticalOffset: 100,
                      child: FadeInAnimation(
                        delay: Duration(milliseconds: 100),
                        child: ListTile(
                          title: Text(_files[index].name),
                          subtitle: Text(_files[index].path),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _files.length,
              ),
            ),
          ],
        ),
        onRefresh: () async => await _getRecycleFiles(),
        color: provider.primaryColor,
        backgroundColor: provider.secondaryColor,
      ),
    );
  }

  _updateRecycleBin() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    _scrollController.animateTo(
      -200,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    if (provider.vibrationIsOpen) Vibration.vibrate(pattern: [0, 10, 250, 20]);
  }

  Future _getRecycleFiles() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    NetFiles(context)
        .recycleFiles()
        .then(
          (files) => setState(() {
            _files = files;
            _listKey = UniqueKey();
          }),
        )
        .then((_) {
      if (provider.vibrationIsOpen) Vibration.vibrate(duration: 20);
    });
  }
}
