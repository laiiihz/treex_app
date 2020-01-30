import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

class QRCodeProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeProfileState();
}

class _QRCodeProfileState extends State<QRCodeProfilePage> {
  Widget _initWidget = Container();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _initWidget = _buildQrProfileImage(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('二维码名片'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('扫一扫'),
          icon: Icon(AntDesign.scan1),
        ),
        body: Center(
          child: Hero(
            tag: 'qrProfile',
            child: Card(
              child: Container(
                height: 400,
                width: 300,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _initWidget,
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        setState(() {
          _initWidget = Container();
        });
        return true;
      },
    );
  }

  Widget _buildQrProfileImage(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                minRadius: 20,
              ),
              Spacer(),
              Text('laiiihz'),
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: QrImage(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                data: 'awefawefagwyefguiawf',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
