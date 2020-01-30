import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/provider/AppProvider.dart';

class ListTitleWidget extends StatefulWidget {
  ListTitleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;
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
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
