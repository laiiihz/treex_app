import 'package:flutter/material.dart';

class LoggerPartWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoggerPartState();
}

class _LoggerPartState extends State<LoggerPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
