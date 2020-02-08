import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/download/downloadSystem.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  Shared _shared;
  @override
  void initState() {
    super.initState();
    //Time to Live func
    functionInit() async {
      await Shared.init(context).then((share) {
        _shared = share;
        _shared
          ..readTransparent()
          ..readPrimaryColor()
          ..readSecondaryColor()
          ..readThemeMode()
          ..readCurvedMode()
          ..readColoredNavi()
          ..readIsHttps()
          ..readNetworkAddr()
          ..readNetworkPort()
          ..readToken()
          ..readDevTools();
      }).then((_) async {
        await Future.delayed(Duration(seconds: 3));
      });

      return;
    }

    functionInit().then((_) {
      Navigator.of(context).pushReplacementNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'logo',
        child: FlareActor(
          'assets/animation/logo.flr',
          fit: BoxFit.cover,
          animation: 'logo',
        ),
      ),
    );
  }
}
