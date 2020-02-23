import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class MessageSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageSettingsPageState();
}

class _MessageSettingsPageState extends State<MessageSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            stretch: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('消息设置'),
              background: LargeIconBackgroundWidget(
                  tag: 'message', icon: Icons.message),
            ),
          ),
        ],
      ),
    );
  }
}
