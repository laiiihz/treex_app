import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:treex_app/UI/MainUI/tools/ScanResult.dart';

class ScanToolPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanToolState();
}

class _ScanToolState extends State<ScanToolPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'qr');
  QRViewController _qrViewController;
  String _qrText = '';
  bool _openTag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(key: _qrKey, onQRViewCreated: _onQRViewCreated),
          ),
          Text(_qrText),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    controller.scannedDataStream.listen((text) {
      if (_openTag) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScanResultPage(),
          ),
        );
      }
      _openTag = false;
    });
  }
}
