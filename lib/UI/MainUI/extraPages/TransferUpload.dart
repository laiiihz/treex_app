import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';

class TransferUploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferUploadState();
}

class _TransferUploadState extends State<TransferUploadPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: MIUIScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Text('test upload');
      },
    );
  }
}
