import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

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
                      showMIUIDialog(
                        context: context,
                        dyOffset: 0.3,
                        content: Container(
                          height: 200,
                          child: ListView(
                            physics: MIUIScrollPhysics(),
                            children: <Widget>[
                              FlatButton(onPressed: () {}, child: Text('5天')),
                              FlatButton(onPressed: () {}, child: Text('10天')),
                              FlatButton(onPressed: () {}, child: Text('15天')),
                              FlatButton(onPressed: () {}, child: Text('10天')),
                              FlatButton(onPressed: () {}, child: Text('25天')),
                              FlatButton(onPressed: () {}, child: Text('30天')),
                            ],
                          ),
                        ),
                        label: 'autoDelete',
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
