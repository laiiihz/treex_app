import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/network/CheckConnection.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:vibration/vibration.dart';

class NetworkPage extends StatefulWidget {
  NetworkPage({
    Key key,
    this.enabled = true,
  }) : super(key: key);
  final bool enabled;
  @override
  State<StatefulWidget> createState() => _NetworkState();
}

class _NetworkState extends State<NetworkPage> {
  StreamSubscription<ConnectivityResult> subscription;
  Widget _iconConnection = Icon(AntDesign.close);
  String _connectionDescription = '';
  TextEditingController _ipTextEditController = TextEditingController();
  TextEditingController _portEditController = TextEditingController();
  Shared _shared;
  bool _isHttpsOn = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final provider = Provider.of<AppProvider>(context, listen: false);
      _initShared() async {
        _shared = await Shared.init(context);
      }

      _initShared();
      _ipTextEditController.text = provider.networkAddr;
      _portEditController.text = provider.networkPort;
      _isHttpsOn = provider.isHttps;
    });
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
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Vibration.vibrate(duration: 10);
              BotToast.showCustomLoading(toastBuilder: (_) {
                return CircularProgressIndicator();
              });
              CheckConnection(
                https: _isHttpsOn,
                addr: _ipTextEditController.text,
                port: _portEditController.text,
              ).check().then((value) {
                BotToast.closeAllLoading();
                BotToast.showNotification(
                  title: (_) => Text(value ? '连接成功' : '连接失败'),
                  trailing: (_) => Icon(
                    value ? Icons.check_circle : Icons.remove_circle,
                    color: value ? Colors.green : Colors.red,
                  ),
                );
              });
            },
            child: Icon(Icons.refresh),
            heroTag: 'test',
          ),
          SizedBox(width: 10),
          widget.enabled
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _shared.writeIsHttps(_isHttpsOn);
                    _shared.writeNetworkAddr(_ipTextEditController.text);
                    _shared.writeNetworkPort(_portEditController.text);
                    provider.changeHttpsStatus(_isHttpsOn);
                    provider.changeNetworkAddr(_ipTextEditController.text);
                    provider.changeNetworkPort(_portEditController.text);
                  },
                  label: Text('保存'),
                  heroTag: 'fab',
                )
              : SizedBox(),
        ],
      ),
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
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(MaterialCommunityIcons.qrcode),
                      onPressed: () {
                        showMIUIDialog(
                          context: context,
                          color: Colors.white,
                          dyOffset: 0.5,
                          content: Container(
                            height: 200,
                            child: QrImage(
                                data:
                                    NetworkConfig(port: '123', addr: 'asdfawef')
                                        .toString()),
                          ),
                          label: 'qrcode',
                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: LargeIconBackgroundWidget(
                      tag: 'network',
                      icon: Icons.wifi,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    TextFieldPadding(
                      child: TextField(
                        enabled: widget.enabled,
                        controller: _ipTextEditController,
                        decoration: InputDecoration(
                          labelText: '服务器地址或IP',
                        ),
                      ),
                    ),
                    TextFieldPadding(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isHttpsOn,
                            onChanged: widget.enabled
                                ? (value) {
                                    setState(() {
                                      _isHttpsOn = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('HTTPS'),
                          Spacer(),
                          Expanded(
                            child: TextField(
                              enabled: widget.enabled,
                              controller: _portEditController,
                              decoration: InputDecoration(labelText: '端口'),
                            ),
                          ),
                        ],
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

class NetworkConfig {
  String port;
  String addr;
  NetworkConfig({
    this.port,
    this.addr,
  });
  Map<String, dynamic> toJSON() {
    return {
      'network': {'port': port, 'addr': addr}
    };
  }

  @override
  String toString() {
    return this.toJSON().toString();
  }
}
