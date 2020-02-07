import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class FriendsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        heroTag: 'fab',
      ),
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('好友列表'),
              background: LargeIconBackgroundWidget(
                  tag: 'messageList', icon:AntDesign.solution1),
            ),
            expandedHeight: 200,
          ),
        ],
      ),
    );
  }
}
