import 'package:flutter/material.dart';

class LOGOWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LOGOState();
}

class _LOGOState extends State<LOGOWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 30,
        ),
        children: [
          TextSpan(
              text: 'Tree',
              style: TextStyle(
                color: Theme.of(context).textTheme.caption.color,
              )),
          TextSpan(text: 'x', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
