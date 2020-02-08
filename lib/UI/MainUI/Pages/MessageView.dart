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
  double _leadingOpacity = 0;
  double _leadingOffsetX = 45;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var offset = _scrollController.offset; //100-145
      if (offset <= 80) {
        setState(() {
          _leadingOpacity = 0;
          _leadingOffsetX = 45;
        });
      } else if (offset < 145) {
        setState(() {
          _leadingOpacity = (offset - 80) / (145 - 80);
          _leadingOffsetX = (1 - (offset - 80) / (145 - 80)) * 45;
        });
      } else {
        setState(() {
          _leadingOpacity = 1;
          _leadingOffsetX = 0;
        });
      }
    });
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
          leading: Transform.translate(
            offset: Offset(_leadingOffsetX, 0),
            child: Opacity(
              opacity: _leadingOpacity,
              child: Icon(Icons.message),
            ),
          ),
          actions: <Widget>[
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
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
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
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  indent: 70,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
