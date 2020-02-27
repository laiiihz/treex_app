import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class QRCodeProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeProfileState();
}

class _QRCodeProfileState extends State<QRCodeProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('二维码名片'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('扫一扫'),
        icon: Icon(MaterialCommunityIcons.qrcode_scan),
        heroTag: 'fab',
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Hero(
                  tag: 'avatar',
                  child: Material(
                    borderRadius: BorderRadius.circular(40),
                    elevation: 10,
                    child: CircleAvatar(
                      backgroundImage: provider.avatarFile == null
                          ? null
                          : FileImage(provider.avatarFile),
                      backgroundColor: isDark(context)
                          ? null
                          : provider.userProfile.backgroundColor,
                      maxRadius: 40,
                      child: provider.userProfile.avatar.isEmpty
                          ? Text(
                              provider.userProfile.name[0],
                              style: TextStyle(fontSize: 30),
                            )
                          : SizedBox(),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Hero(
                tag: 'myName',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    '${provider.userProfile.name} ',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: QrImage(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  data: ProfileConfig(provider.userProfile.name).toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileConfig {
  String name;
  ProfileConfig(this.name);

  String toJSON() {
    return jsonEncode({
      'tag': 'profile',
      'profile': {
        'name': name,
      }
    });
  }

  @override
  String toString() {
    return this.toJSON();
  }
}
