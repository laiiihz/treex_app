import 'package:flutter/material.dart';

Widget buildEmpty(bool empty) {
  return SliverToBoxAdapter(
    child: buildEmptyNormal(empty),
  );
}

Widget buildEmptyNormal(
  bool empty, {
  String value = '空目录',
}) {
  return empty
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
                Text(value),
              ],
            ),
          ),
        )
      : SizedBox(height: 0);
}
