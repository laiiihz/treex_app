import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class RecycleBinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBinPage> {
  ScrollController _scrollController = ScrollController();
  List<RecycleFileEntity> _files = [];
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(milliseconds: 300), () {
      _getRecycleFiles();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _scrollController.dispose();
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
            actions: <Widget>[
              Tooltip(
                message: '清空文件',
                child: IconButton(
                    icon: Icon(Icons.delete_forever), onPressed: () {}),
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text(_files[index].name),
                  subtitle: Text(_files[index].path),
                );
              },
              childCount: _files.length,
            ),
          ),
        ],
      ),
    );
  }

  _getRecycleFiles() {
    _scrollController.animateTo(
      -100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    NetFiles(context).recycleFiles().then((files) {
      setState(() {
        _files = files;
      });
    });
  }
}
