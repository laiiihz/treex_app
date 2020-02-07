import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

class RecycleBinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBinPage> {
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
        ],
      ),
    );
  }
}
