import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget genFileType(List<String> list) {
  return Container(
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: OutlineButton(
            onPressed: () {},
            child: Text(
              list[index],
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        );
      },
      itemCount: list.length,
    ),
  );
}
