import 'package:flutter/material.dart';

Widget buildEmpty(bool empty) {
  return SliverToBoxAdapter(
    child: empty
        ? Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.inbox,
                    size: 50,
                  ),
                  Text('空目录'),
                ],
              ),
            ),
          )
        : SizedBox(height: 0),
  );
}
