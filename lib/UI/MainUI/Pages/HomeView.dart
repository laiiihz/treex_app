import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/MainUI/extra/AppSearchDelegate.dart';
import 'package:treex_app/UI/widget/LOGO.dart';
import 'package:treex_app/generated/i18n.dart';

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
                  showSearch(
                      context: context,
                      delegate: AppSearchDelegate(
                          hintText: I18n.of(context).searchString));
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
