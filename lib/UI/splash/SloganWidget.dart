import 'dart:math';

import 'package:flutter/material.dart';

List<String> slogan = [
  'Private',
  '隐私',
  '云',
  'Cloud',
  'Based',
  '安全',
  'Secure',
  'Powerful',
  'Open',
  'Source',
  'Fast',
  '快捷',
  '快速',
  'Easy',
  'Free',
  '免费',
  'Message',
  'Transfer',
  'Http',
  'Flutter',
  'Web',
  'Desktop',
  'iOS',
  'Android',
  '消息',
  '云服务',
  '共享',
  '开源',
  'Dart',
  'GPL',
  'Github',
];

class SloganWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SloganState();
}

class _SloganState extends State<SloganWidget> {
  List<Text> _displayList = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      _displayList.add(
        Text(
          slogan[Random().nextInt(slogan.length)].toUpperCase(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: int2Font[Random().nextInt(8)],
          ),
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _displayList,
    );
  }
}

Map<int, FontWeight> int2Font = {
  0: FontWeight.w100,
  1: FontWeight.w200,
  2: FontWeight.w300,
  3: FontWeight.w400,
  4: FontWeight.w500,
  5: FontWeight.w600,
  6: FontWeight.w700,
  7: FontWeight.w800,
  8: FontWeight.w900,
};
