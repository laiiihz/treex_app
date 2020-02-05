import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/UI/MainUI/extra/About.dart';

class AuthorDisplayWidget extends StatefulWidget {
  AuthorDisplayWidget({
    Key key,
    @required this.authorCard,
  }) : super(key: key);
  final AuthorCard authorCard;
  @override
  State<StatefulWidget> createState() => _AuthorDisplayState();
}

class _AuthorDisplayState extends State<AuthorDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.authorCard.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.authorCard.onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          child: Container(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                widget.authorCard.icon,
                Text(widget.authorCard.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
