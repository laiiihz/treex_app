import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/MainUI/extraPages/friends/SingleFriendView.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class MessageViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageViewWidget> {
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: -500);
  bool showIcon = false;
  @override
  void initState() {
    super.initState();
    bool lockUp = false;
    bool lockDown = false;
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 145) {
        if (!lockUp) {
          lockUp = true;
          setState(() {
            showIcon = false;
          });
          lockDown = false;
        }
      } else {
        if (!lockDown) {
          lockDown = true;
          setState(() {
            showIcon = true;
          });
        }
        lockUp = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: MIUIScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          stretch: true,
          leading: AnimatedOpacity(
            opacity: showIcon ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.message),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.group),
              onPressed: () {
                Navigator.of(context).pushNamed('groupChannel');
              },
            ),
            IconButton(
              icon: Hero(
                tag: 'messageList',
                child: Icon(AntDesign.solution1),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('friendsList');
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text('消息'),
            background:
                LargeIconBackgroundWidget(tag: 'message', icon: Icons.message),
          ),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: Hero(
                  tag: 'friend$index',
                  child: CircleAvatar(),
                ),
                title: Hero(
                  tag: 'friendName$index',
                  child: Material(
                    color: Colors.transparent,
                    child: Text('friend 0$index'),
                  ),
                ),
                onTap: () {
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleFriendViewPage(
                          heroTagAvatar: 'friend$index',
                          heroTagTitle: 'friendName$index',
                        ),
                      ),
                    );
                  });
                },
              );
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }
}
