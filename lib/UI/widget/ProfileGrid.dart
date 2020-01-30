import 'package:flutter/material.dart';

class ProfileGridWidget extends StatefulWidget {
  ProfileGridWidget({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);
  final String text;
  final Widget icon;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _ProfileGridState();
}

class _ProfileGridState extends State<ProfileGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: widget.icon,
          onPressed: widget.onTap,
        ),
        Text(widget.text),
      ],
    );
  }
}
