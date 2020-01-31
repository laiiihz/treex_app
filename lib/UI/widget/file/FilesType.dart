import 'package:flutter/material.dart';

Widget genFileType(List<String> list) {
  List<Widget> rowList = [];
  int count = list.length ~/ 4;
  for (int i = 0; i < count; i++) {
    List<Widget> row = [];
    for (int j = 0; j < 4; j++) {
      row.add(OutlineButton(
        onPressed: () {},
        child: Text(list[4 * i + j]),
      ));
    }
    rowList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: row,
      ),
    );
  }

  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: rowList,
    ),
  );
}
