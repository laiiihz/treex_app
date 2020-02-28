import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/network/CheckConnection.dart';
import 'package:treex_app/network/NetworkProfileUtil.dart';

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
      await Shared.init(context).then((share) async {
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
          ..readVibrationState()
          ..readDevTools();

        await _shared.readFastInit().then((state) async {
          if (!state) {
            await Future.delayed(Duration(seconds: 3));
          }
        });
      });

      return;
    }

    functionInit().then((_) {
      if ((_shared.provider.token as String).isNotEmpty) {
        CheckUserConnection(context).check().then((value) {
          print('value:$value');
          if (value) {
            NetworkProfileUtil(context).getProfile().then((profile) async {
              _shared.provider.changeProfile(profile);
              if (profile.avatar.isNotEmpty) {
                await FileUtil.build(context).then((fileUtil) {
                  _shared.provider.changeAvatarFile(fileUtil.getAvatarFile());
                });
              }
            }).then((_) {
              Navigator.of(context).pushReplacementNamed('home');
            });
          } else {
            Navigator.of(context).pushReplacementNamed('login');
          }
        });
      } else
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
