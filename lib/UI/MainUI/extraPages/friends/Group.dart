import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extraPages/friends/widget/TreexChatBox.dart';
import 'package:treex_app/UI/widget/ProfileGrid.dart';
import 'package:treex_app/Utils/HideSoftKeyboard.dart';
import 'package:treex_app/provider/AppProvider.dart';

class GroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupState();
}

class _GroupState extends State<GroupPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _chatMessages = [];
  final FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
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
              padding: EdgeInsets.only(bottom: 10),
              reverse: true,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return TreexChatBox(
                  message: _chatMessages[index],
                );
              },
              itemCount: _chatMessages.length,
            ),
          ),
          Material(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_focusNode);
                        setState(() {
                          _chatMessages.insert(0, _textEditingController.text);
                        });
                        _textEditingController.clear();
                        _scrollController.animateTo(
                          -20,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOutCubic,
                        );
                        //TODO websocket
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      showMIUIDialog(
                          context: context,
                          dyOffset: 0.2,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ProfileGridWidget(
                                text: '相册',
                                icon: Icon(MaterialCommunityIcons.image),
                                onTap: () {},
                              ),
                              ProfileGridWidget(
                                text: '相机',
                                icon: Icon(MaterialCommunityIcons.camera),
                                onTap: () {},
                              ),
                            ],
                          ),
                          label: 'camera');
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: () {
                        hideSoftKeyboard(context);
                        showMIUIDialog(
                          context: context,
                          dyOffset: 0.4,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ProfileGridWidget(
                                text: '文件',
                                icon: Icon(MaterialCommunityIcons.file),
                                onTap: () {},
                              ),
                              ProfileGridWidget(
                                text: '文档',
                                icon:
                                    Icon(MaterialCommunityIcons.file_document),
                                onTap: () {},
                              ),
                              ProfileGridWidget(
                                text: '二维码',
                                icon: Icon(MaterialCommunityIcons.qrcode),
                                onTap: () {},
                              ),
                              ProfileGridWidget(
                                text: '链接',
                                icon: Icon(MaterialCommunityIcons.link),
                                onTap: () {},
                              ),
                            ],
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
