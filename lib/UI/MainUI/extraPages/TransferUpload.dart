import 'package:flutter/material.dart';

class TransferUploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferUploadState();
}

class _TransferUploadState extends State<TransferUploadPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Text('test upload');
      },
    );
  }
}