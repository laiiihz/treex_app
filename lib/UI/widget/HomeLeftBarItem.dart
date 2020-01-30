import 'package:flutter/material.dart';
import 'package:treex_app/Utils/DarkModeUtil.dart';

class HomeLeftBarItemWidget extends StatefulWidget {
  HomeLeftBarItemWidget({
    Key key,
    @required this.index,
    this.nowIndex = 0,
    this.leading,
    this.title,
    this.onTap,
  }) : super(key: key);
  final int index;
  final int nowIndex;
  final Widget leading;
  final String title;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _HomeLeftBarItemState();
}

class _HomeLeftBarItemState extends State<HomeLeftBarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
      child: Material(
        color: widget.nowIndex == widget.index
            ? primaryBackgroundColor(context)
            : null,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                widget.leading,
                SizedBox(width: 20),
                Text(widget.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
