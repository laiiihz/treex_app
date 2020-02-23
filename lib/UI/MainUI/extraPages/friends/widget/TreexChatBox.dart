import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';

enum CHAT_BOX_DIRECTION {
  LEFT,
  RIGHT,
}

class TreexChatBox extends StatefulWidget {
  TreexChatBox({
    Key key,
    this.message,
    this.direction = CHAT_BOX_DIRECTION.RIGHT,
  }) : super(key: key);
  final String message;
  final CHAT_BOX_DIRECTION direction;
  @override
  State<StatefulWidget> createState() => _TreexChatBoxState();
}

class _TreexChatBoxState extends State<TreexChatBox> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.direction == CHAT_BOX_DIRECTION.RIGHT ? Spacer() : SizedBox(),
        widget.direction == CHAT_BOX_DIRECTION.RIGHT
            ? SizedBox()
            : _buildAvatar(),
        Padding(
          padding: EdgeInsets.only(top: 20,right: 5),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: mediaQuery.size.width * 0.618),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: provider.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SelectableText(
              widget.message,
              toolbarOptions: ToolbarOptions(
                selectAll: true,
                copy: true,
              ),
            ),
          ),
        ),
        widget.direction == CHAT_BOX_DIRECTION.RIGHT
            ? _buildAvatar()
            : SizedBox(),
        widget.direction == CHAT_BOX_DIRECTION.RIGHT ? SizedBox() : Spacer(),
      ],
    );
  }

  Widget _buildAvatar() {
    final provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: CircleAvatar(
        backgroundColor: provider.primaryColor,
      ),
    );
  }
}
