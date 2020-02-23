import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:treex_app/UI/MainUI/tools/ScanResult.dart';
import 'package:vibration/vibration.dart';

class ScanToolPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanToolState();
}

class _ScanToolState extends State<ScanToolPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'qr');
  QRViewController _qrViewController;
  String _qrText = '';
  bool _openTag = true;
  bool _flashOn = false;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'flash',
            child: AnimatedCrossFade(
              firstChild: Icon(Icons.flash_on),
              secondChild: Icon(Icons.flash_off),
              crossFadeState: _flashOn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
            ),
            onPressed: () {
              setState(() => _flashOn = !_flashOn);
              _qrViewController.toggleFlash();
            },
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'fab',
            onPressed: () {},
          ),
        ],
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
        Vibration.vibrate(pattern: [0, 10, 50, 10]);
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
