import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/ToolGridItem.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class FullToolsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullToolsState();
}

class _FullToolsState extends State<FullToolsPage> {
  double _maskHeight = 0;
  double _maskWidth = 0;
  double _maskRadius = 300;
  double _maskOpacity = 0;
  Alignment _alignment = Alignment(0, 1.5);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _maskWidth = MediaQuery.of(context).size.width;
        _maskHeight = MediaQuery.of(context).size.height;
        _maskRadius = 0;
        _alignment = Alignment(0, 0.9);
        _maskOpacity = 1;
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
                    child: InkWell(
                      onTap: () {
                        willPopFunc().then((_) {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_maskRadius),
                      color: isDark(context) ? Colors.black87 : Colors.white70,
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
                      icon: AntDesign.scan1,
                      onTap: () {
                        Navigator.of(context).pushNamed('scan');
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
    });
    final provider = Provider.of<AppProvider>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: provider.primaryColor,
    ));
    provider.changeFABDisplay(true);
    await Future.delayed(Duration(milliseconds: 520), () {});
    return true;
  }
}
