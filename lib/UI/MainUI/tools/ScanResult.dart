import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extra/Network.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanResultPage extends StatefulWidget {
  ScanResultPage({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<StatefulWidget> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResultPage> {
  dynamic jsonObject;
  String _displayText = '';
  bool _showText = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.text[0] == '{') {
        jsonObject = jsonDecode(widget.text);
        final provider = Provider.of<AppProvider>(context, listen: false);
        switch (jsonObject['tag']) {
          case 'network':
            NetworkConfig networkConfig = NetworkConfig.build(jsonObject);
            provider.changeNetworkConfig(networkConfig);
            Navigator.of(context).pushReplacementNamed('network');
            break;
          case 'profile':
            if (jsonObject['profile']['name'] == provider.userProfile.name) {
              Navigator.of(context).pushReplacementNamed('profile');
            } else {
              Navigator.of(context).pop();
            }
            print(
                '${jsonObject['profile']['name']}@@@@@@${provider.userProfile.name}');
            break;
          default:
        }
      } else if (RegExp(r'[\s]').hasMatch(widget.text)) {
        setState(() {
          _displayText = widget.text;
          _showText = true;
        });
      } else if (RegExp(r'[\S]+[.][\S]+').hasMatch(widget.text)) {
        canLaunch(widget.text).then((value) {
          if (value) {
            launch(widget.text);
            Navigator.of(context).pop();
          }
        });
      } else {
        setState(() {
          _displayText = widget.text;
          _showText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Padding(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(),
          ),
          secondChild: SelectableText(_displayText),
          crossFadeState:
              _showText ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
