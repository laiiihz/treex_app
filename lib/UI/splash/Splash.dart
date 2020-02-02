import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //Time to Live func
    Future.delayed(Duration.zero, () {
      Shared(context).readTransparent();
      Shared(context).readPrimaryColor();
      Shared(context).readSecondaryColor();
      Shared(context).readThemeMode();
      Shared(context).readCurvedMode();
      Shared(context).readColoredNavi();
      Shared(context).readSlideBackMode();
      Shared(context).readDevTools();
    }).then((_){
      Future.delayed(Duration(milliseconds: 2500), () {
        Navigator.of(context).pushReplacementNamed('login');
      });
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
