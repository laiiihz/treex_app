import 'package:flutter/material.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

enum ChatDirection {
  LEFT,
  RIGHT,
}

class ChatBoxWidget extends StatefulWidget {
  ChatBoxWidget({
    Key key,
    this.chatDirection = ChatDirection.LEFT,
  }) : super(key: key);
  final ChatDirection chatDirection;
  @override
  State<StatefulWidget> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.chatDirection == ChatDirection.RIGHT ? Spacer() : SizedBox(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: widget.chatDirection == ChatDirection.LEFT
                  ? isDark(context) ? Colors.white24 : Colors.black26
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    widget.chatDirection == ChatDirection.LEFT ? 0 : 10),
                topRight: Radius.circular(
                    widget.chatDirection == ChatDirection.LEFT ? 10 : 0),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width - 80,
                child: Text(
                  'testauhrgaiuhrgiigawrueighuaiwoerghf',
                ),
              ),
            ),
          ),
        ),
        widget.chatDirection == ChatDirection.RIGHT ? SizedBox() : Spacer(),
      ],
    );
  }
}
