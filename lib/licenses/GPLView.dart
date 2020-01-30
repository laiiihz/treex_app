import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/licenses/licenses.dart';

class GPLViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GPLViewState();
}

class _GPLViewState extends State<GPLViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPL v3'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        physics: MIUIScrollPhysics(),
        child: MarkdownBody(
          data: Licenses.UserAgreement,
        ),
      ),
    );
  }
}
