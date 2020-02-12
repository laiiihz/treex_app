import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/tools/QRCodeProfile.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/ProfileGrid.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ProfileViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileViewWidget> {
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: -500);
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return CustomScrollView(
      controller: _scrollController,
      physics: MIUIScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: provider.userProfile.backgroundColor,
          stretch: true,
          pinned: true,
          expandedHeight: 350,
          flexibleSpace: FlexibleSpaceBar(
            background: buildWaveWithAvatar(
              context: context,
              child: buildWaveFrontAvatar(context),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            FlipCard(
              front: CardBarWidget(
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 10,
                      value: 0.1,
                      backgroundColor:
                          isDark(context) ? Colors.white30 : Colors.black26,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(provider.primaryColor),
                    ),
                    Spacer(),
                    Text(
                      '已使用:2GB/20GB',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            isDark(context) ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              back: CardBarWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(AntDesign.picture),
                        SizedBox(
                          height: 10,
                        ),
                        Text('432'),
                      ],
                    ),
                    VerticalDivider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(AntDesign.videocamera),
                        SizedBox(
                          height: 10,
                        ),
                        Text('432'),
                      ],
                    ),
                    VerticalDivider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(MaterialIcons.audiotrack),
                        SizedBox(
                          height: 10,
                        ),
                        Text('12'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardBarWidget(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ProfileGridWidget(
                      onTap: () {
                        Navigator.of(context).pushNamed('network');
                      },
                      icon: Hero(
                        tag: 'network',
                        child: Icon(Icons.wifi),
                      ),
                      text: '网络设置',
                    ),
                    ProfileGridWidget(
                        icon: Hero(
                          tag: 'lock',
                          child: Icon(Icons.lock),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('safety');
                        },
                        text: '安全设置'),
                    ProfileGridWidget(
                        icon: Icon(Icons.message), onTap: () {}, text: '消息设置'),
                    ProfileGridWidget(
                        icon: Hero(
                          tag: 'settings',
                          child: Icon(Icons.settings),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('settings');
                        },
                        text: '高级设置'),
                  ],
                ),
              ),
            ),
            CardPadding10(
              child: Padding(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {},
                  child: Text('退出登录'),
                  textColor: Colors.red,
                ),
              ),
            ),
            ListTile(
              contentPadding: edgeInsetsGeometryCurved(context),
              leading:
                  Hero(tag: 'about', child: Icon(AntDesign.exclamationcircle)),
              title: Text('关于'),
              subtitle: Text('version:0.0.1-master'),
              onTap: () {
                Navigator.of(context).pushNamed('about');
              },
            ),
            ListTile(
              onTap: () {},
              contentPadding: edgeInsetsGeometryCurved(context),
              leading: Icon(AntDesign.questioncircle),
              title: Text('常见问题'),
            ),
            provider.devTool
                ? ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('devTool');
                    },
                    contentPadding: edgeInsetsGeometryCurved(context),
                    leading: Icon(Icons.developer_mode),
                    title: Text('开发者工具'),
                  )
                : SizedBox(),
          ]),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 300,
          ),
        ),
      ],
    );
  }
}

Widget buildWaveWithAvatar({@required BuildContext context, Widget child}) {
  return Stack(
    overflow: Overflow.visible,
    children: <Widget>[
      Container(
        child: WaveWidget(
          config: CustomConfig(
            durations: [30000, 20000, 15000, 10000],
            heightPercentages: [0.2, 0.4, 0.6, 0.75],
            colors: [
              Colors.white10,
              Colors.white10,
              Colors.white10,
              Colors.white10,
            ],
          ),
          size: Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
      child == null ? SizedBox() : child,
    ],
  );
}

Widget buildWaveFrontAvatar(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return Center(
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 0, top: 20, bottom: 20),
      child: Row(
        children: <Widget>[
          Hero(
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
          Hero(
              tag: 'qrProfile',
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                    icon: Icon(AntDesign.qrcode),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QRCodeProfilePage()));
                    }),
              )),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context).pushNamed('profile');
              }),
        ],
      ),
    ),
  );
}
