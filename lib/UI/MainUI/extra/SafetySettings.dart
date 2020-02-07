import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/UI/widget/ListTitle.dart';

class SafetySettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SafetySettingsState();
}

class _SafetySettingsState extends State<SafetySettingsPage> {
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
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('安全设置'),
              background:
                  LargeIconBackgroundWidget(tag: 'lock', icon: Icons.lock),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTitleWidget(title: '个人安全设置'),
              TextFieldPadding(
                child: TextField(
                  decoration: InputDecoration(labelText: '修改密码'),
                ),
              ),
              ListTitleWidget(title: '危险区', color: Colors.red),
              ListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                leading: Icon(
                  MaterialCommunityIcons.delete_forever,
                  color: Colors.pink,
                ),
                title: Text(
                  '清空所有云端数据',
                  style: TextStyle(color: Colors.pink),
                ),
                onTap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
