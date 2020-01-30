import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('关于'),
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text('开源许可'),
                onTap: () {
                  Navigator.of(context).pushNamed('licenses');
                },
                leading: Icon(AntDesign.codesquare),
              ),
              ListTile(
                title: Text('用户使用协议'),
                onTap: () {},
                leading: Icon(AntDesign.user),
              ),
              ListTile(
                title: Text('GPL v3'),
                onTap: () {
                  Navigator.of(context).pushNamed('licenses_gpl');
                },
                leading: Icon(AntDesign.codesquareo),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
