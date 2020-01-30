import 'package:flutter/material.dart';

class ToolGridItemWidget extends StatefulWidget {
  ToolGridItemWidget({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _ToolGridItemState();
}

class _ToolGridItemState extends State<ToolGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          onPressed: widget.onTap,
          child: Icon(widget.icon),
          heroTag: UniqueKey().toString(),
        ),
        SizedBox(height: 5),
        Text(widget.title),
      ],
    );
  }
}
