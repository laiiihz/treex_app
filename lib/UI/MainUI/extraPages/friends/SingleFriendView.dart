import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/Chat/ChatBox.dart';
import 'package:treex_app/Utils/HideSoftKeyboard.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

class SingleFriendViewPage extends StatefulWidget {
  SingleFriendViewPage({
    Key key,
    this.heroTagAvatar,
    this.heroTagTitle,
  }) : super(key: key);
  final String heroTagAvatar;
  final String heroTagTitle;
  @override
  State<StatefulWidget> createState() => _SingleFriendViewState();
}

class _SingleFriendViewState extends State<SingleFriendViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: widget.heroTagAvatar,
                child: CircleAvatar(),
              ),
              SizedBox(width: 10),
              Hero(
                tag: widget.heroTagTitle,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'test',
                    style: TextStyle(
                      color: isDark(context) ? Colors.black : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            physics: MIUIScrollPhysics(),
            padding: EdgeInsets.only(bottom: 60),
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Random().nextBool()
                  ? ChatBoxWidget()
                  : ChatBoxWidget(
                      chatDirection: ChatDirection.RIGHT,
                    );
            },
          ),
          AnimatedAlign(
            alignment: Alignment(0, 1),
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 500),
            child: Material(
              child: Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextField()),
                    IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {
                          hideSoftKeyboard(context);
                          showMIUIDialog(
                            context: context,
                            dyOffset: 0.4,
                            content: Container(
                              height: 150,
                            ),
                            label: 'extra',
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
