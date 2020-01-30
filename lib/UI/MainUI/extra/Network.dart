import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';

class NetworkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkState();
}

class _NetworkState extends State<NetworkPage> {
  StreamSubscription<ConnectivityResult> subscription;
  Widget _iconConnection = Icon(AntDesign.close);
  String _connectionDescription = '';
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.none:
          setState(() {
            _iconConnection = Icon(AntDesign.close);
          });

          break;
        case ConnectivityResult.wifi:
          setState(() {
            _iconConnection = Icon(AntDesign.wifi);
          });
          Connectivity().getWifiIP().then((value) {
            setState(() {
              _connectionDescription = value;
            });
          });
          break;
        case ConnectivityResult.mobile:
          setState(() {
            _iconConnection = Icon(AntDesign.swap);
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              physics: MIUIScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  stretch: true,
                  title: Text('网络设置'),
                  flexibleSpace: FlexibleSpaceBar(
                    background: LargeIconBackgroundWidget(
                      tag: 'network',
                      icon: Icons.wifi,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 10),
                    CardPadding10(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: TextField(),
                      ),
                    ),
                    SizedBox(height: 10),
                    CardPadding10(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: TextField(),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _iconConnection,
                  Text(_connectionDescription ?? 'none'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
