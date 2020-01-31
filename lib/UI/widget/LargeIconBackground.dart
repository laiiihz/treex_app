import 'package:flutter/material.dart';

class LargeIconBackgroundWidget extends StatefulWidget {
  LargeIconBackgroundWidget({
    Key key,
    @required this.tag,
    @required this.icon,
  }) : super(key: key);
  final String tag;
  final IconData icon;
  @override
  State<StatefulWidget> createState() => _LargeIconBackgroundState();
}

class _LargeIconBackgroundState extends State<LargeIconBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Hero(
        tag: widget.tag,
        child: Opacity(
          opacity: 0.7,
          child: Icon(
            widget.icon,
            size: 170,
          ),
        ),
      ),
    );
  }
}
