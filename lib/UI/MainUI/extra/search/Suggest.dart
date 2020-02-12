import 'package:flutter/material.dart';

class SuggestWidget extends StatefulWidget {
  SuggestWidget({Key key, @required this.query}) : super(key: key);
  final String query;
  @override
  State<StatefulWidget> createState() => _SuggestWidgetState();
}

class _SuggestWidgetState extends State<SuggestWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: widget.query.length == 0
          ? Center(
              child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
            )
          : Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('搜索${widget.query}'),
                )
              ],
            ),
    );
  }
}
