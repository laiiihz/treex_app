import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/HideSoftKeyboard.dart';
import 'package:treex_app/provider/AppProvider.dart';

class GroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupState();
}

class _GroupState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('公共群组'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: ListView.builder(
              physics: MIUIScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Chip(
                    avatar: Icon(Icons.group),
                    label: Text('在线人数:1'),
                    backgroundColor: provider.primaryColor,
                  ),
                );
              },
              itemCount: 1,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: MIUIScrollPhysics(),
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return Text("test");
              },
            ),
          ),
          Material(
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
        ],
      ),
    );
  }
}
