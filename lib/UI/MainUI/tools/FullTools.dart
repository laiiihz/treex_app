import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/tools/QRCodeProfile.dart';
import 'package:treex_app/UI/widget/ToolGridItem.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:vibration/vibration.dart';

class FullToolsPage extends StatefulWidget {
  FullToolsPage({
    Key key,
    @required this.color,
  }) : super(key: key);
  final Color color;
  @override
  State<StatefulWidget> createState() => _FullToolsState();
}

class _FullToolsState extends State<FullToolsPage>
    with TickerProviderStateMixin {
  double _maskHeight = 0;
  double _maskWidth = 0;
  double _maskRadius = 300;
  double _maskOpacity = 0;
  Alignment _alignment = Alignment(0, 1.5);
  Color _initColor;
  AnimationController _animationController;
  Animation _blurAnimation;
  @override
  void initState() {
    super.initState();
    _initColor = widget.color;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _blurAnimation = Tween(begin: 0.0, end: 5.0).animate(_animationController);
    Future.delayed(Duration(milliseconds: 500), () {
      _animationController.fling(velocity: 1.0);
    });

    Future.delayed(Duration.zero, () {
      setState(() {
        _maskWidth = MediaQuery.of(context).size.width;
        _maskHeight = MediaQuery.of(context).size.height;
        _maskRadius = 0;
        _alignment = Alignment(0, 0.9);
        _maskOpacity = 1;
        _initColor = isDark(context) ? Colors.black38 : Colors.white30;
      });
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black87,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(1, 0.9),
                child: AnimatedOpacity(
                  opacity: _maskOpacity,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCubic,
                    duration: Duration(milliseconds: 500),
                    height: _maskHeight,
                    width: _maskWidth,
                    child: ClipRect(
                      child: AnimatedBuilder(
                        animation: _blurAnimation,
                        builder: (BuildContext context, Widget child) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: _blurAnimation.value,
                              sigmaY: _blurAnimation.value,
                            ),
                            child: child,
                          );
                        },
                        child: InkWell(
                          child: Text(' '),
                          onTap: () {
                            willPopFunc().then((_) {
                              Navigator.of(context).pop();
                            });
                            if (provider.vibrationIsOpen)
                              Vibration.vibrate(pattern: [200, 20, 300, 10]);
                          },
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_maskRadius),
                      color: _initColor,
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: _alignment,
                curve: Curves.easeInOutCubic,
                duration: Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ToolGridItemWidget(
                      title: '扫一扫',
                      icon: MaterialCommunityIcons.qrcode_scan,
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('scan');
                        provider.changeFABDisplay(true);
                      },
                    ),
                    ToolGridItemWidget(
                      title: '我的二维码名片',
                      icon: MaterialCommunityIcons.qrcode,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => QRCodeProfilePage(),
                        ));
                        provider.changeFABDisplay(true);
                      },
                    ),
                    ToolGridItemWidget(
                      title: '添加好友',
                      icon: MaterialCommunityIcons.account_plus,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: willPopFunc);
  }

  Future<bool> willPopFunc() async {
    setState(() {
      _maskWidth = 58;
      _maskRadius = 300;
      _maskHeight = 58;
      _alignment = Alignment(0, 1.5);
      _maskOpacity = 0;
      _initColor = widget.color;
    });
    final provider = Provider.of<AppProvider>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: provider.primaryColor,
    ));
    Future.delayed(Duration(milliseconds: 200), () {
      provider.changeFABDisplay(true);
    });
    await Future.delayed(Duration(milliseconds: 520), () {});
    return true;
  }
}
