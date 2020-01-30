import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/MainUI/extra/AppSearchDelegate.dart';
import 'package:treex_app/UI/widget/LOGO.dart';

class HomeViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: MIUIScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          title: LOGOWidget(),
          actions: <Widget>[
            Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: AppSearchDelegate());
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'scan',
                      child: Row(
                        children: <Widget>[
                          Icon(AntDesign.scan1),
                          Spacer(),
                          Text('扫一扫'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'add',
                      child: Row(
                        children: <Widget>[
                          Icon(AntDesign.adduser),
                          Spacer(),
                          Text('添加'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: <Widget>[
                          Icon(AntDesign.setting),
                          Spacer(),
                          Text('设置'),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) {
                  switch (value) {
                    case 'scan':
                      Navigator.of(context).pushNamed('scan');
                      break;
                    case 'settings':
                      Navigator.of(context).pushNamed('settings');
                      break;
                  }
                },
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: CarouselSlider.builder(
              autoPlay: true,
              height: 240,
              autoPlayCurve: Curves.easeInOutCubic,
              autoPlayInterval: Duration(milliseconds: 4000),
              itemCount: 5,
              aspectRatio: 1,
              viewportFraction: 1.0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/imgs/nasa-${index + 1}.webp',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          expandedHeight: 200,
        ),
      ],
    );
  }
}
