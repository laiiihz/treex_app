import 'package:flutter/material.dart';
import 'package:treex_app/UI/widget/CardBar.dart';

class ListTitleWidget extends StatefulWidget {
  ListTitleWidget({
    Key key,
    @required this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color color ;
  @override
  State<StatefulWidget> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: edgeInsetsGeometryCurved(context),
      title: Text(
        widget.title,
        style: TextStyle(color: widget.color==null?Theme.of(context).primaryColor:widget.color),
      ),
    );
  }
}
