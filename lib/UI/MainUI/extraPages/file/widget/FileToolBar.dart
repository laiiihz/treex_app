import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';

Widget buildToolBar({
  @required BuildContext context,
  bool showToolBar = true,
  VoidCallback goBack,
  String nowPath,
}) {
  return SliverToBoxAdapter(
    child: showToolBar
        ? CardPadding10(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: roundBorder10,
        child: Row(
          children: <Widget>[
            Tooltip(
              message: '回到上一级',
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: goBack,
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                child: ListView.builder(
                  physics: MIUIScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text('${nowPath.split('/')[index]}/'),
                    );
                  },
                  itemCount: nowPath.split('/').length,
                ),
              ),
            ),
          ],
        ),
      ),
    )
        : SizedBox(),
  );
}