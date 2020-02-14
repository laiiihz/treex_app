import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/Pages/FileView.dart';
import 'package:treex_app/UI/MainUI/Pages/HomeView.dart';
import 'package:treex_app/UI/MainUI/Pages/MessageView.dart';
import 'package:treex_app/UI/MainUI/Pages/ProfileView.dart';
import 'package:treex_app/UI/MainUI/tools/FullTools.dart';
import 'package:treex_app/UI/widget/HomeLeftBarItem.dart';

import 'package:treex_app/UI/widget/TransparentPageRoute.dart';
import 'package:treex_app/generated/i18n.dart';
import 'package:treex_app/provider/AppProvider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _nowIndex = 0;
  PageController _pageController = PageController();
  Key _customKey = UniqueKey();
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Orientation.landscape == orientation
            ? _landscapeView(context)
            : _portraitView(context);
      },
    );
  }

  Widget _landscapeView(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: 300,
            child: Drawer(
              child: ListView(
                physics: MIUIScrollPhysics(),
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: buildWaveWithAvatar(context: context),
                  ),
                  HomeLeftBarItemWidget(
                    index: 0,
                    nowIndex: _nowIndex,
                    title: I18n.of(context).bottomHome,
                    leading: Icon(Icons.home),
                    onTap: () {
                      setState(() {
                        _nowIndex = 0;
                      });
                      _pageController.jumpToPage(0);
                    },
                  ),
                  HomeLeftBarItemWidget(
                    index: 1,
                    nowIndex: _nowIndex,
                    title: I18n.of(context).bottomCloud,
                    leading: Icon(Icons.folder),
                    onTap: () {
                      setState(() {
                        _nowIndex = 1;
                      });
                      _pageController.jumpToPage(1);
                    },
                  ),
                  HomeLeftBarItemWidget(
                    index: 3,
                    nowIndex: _nowIndex,
                    title: I18n.of(context).bottomMessage,
                    leading: Icon(Icons.message),
                    onTap: () {
                      setState(() {
                        _nowIndex = 2;
                      });
                      _pageController.jumpToPage(2);
                    },
                  ),
                  HomeLeftBarItemWidget(
                    index: 3,
                    nowIndex: _nowIndex,
                    title: I18n.of(context).bottomProfile,
                    leading: Icon(Icons.account_circle),
                    onTap: () {
                      setState(() {
                        _nowIndex = 3;
                      });
                      _pageController.jumpToPage(3);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _homePages(context)),
        ],
      ),
    );
  }

  Widget _portraitView(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: _homePages(context),
      floatingActionButton: provider.showFAB
          ? FloatingActionButton(
              child: Icon(Icons.add),
              key: _customKey,
              onPressed: () {
                provider.changeFABDisplay(false);
                Navigator.of(context).push(TransparentPageRoute(
                  builder: (context) => FullToolsPage(),
                ));
              },
              heroTag: 'fab',
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            provider.bottomBarColored ? provider.primaryColor : null,
        selectedItemColor:
            provider.bottomBarColored ? Colors.white : provider.primaryColor,
        unselectedItemColor: provider.bottomBarColored ? Colors.white70 : null,
        currentIndex: _nowIndex,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _customKey = UniqueKey();
          });
          setState(() {
            _nowIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.home_outline),
            title: Text(I18n.of(context).bottomHome),
            activeIcon: Icon(MaterialCommunityIcons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.cloud_outline),
            title: Text(I18n.of(context).bottomCloud),
            activeIcon: Icon(MaterialCommunityIcons.cloud),
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.message_outline),
            title: Text(I18n.of(context).bottomMessage),
            activeIcon: Icon(MaterialCommunityIcons.message),
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.account_outline),
            title: Text(I18n.of(context).bottomProfile),
            activeIcon: Icon(MaterialCommunityIcons.account),
          ),
        ],
      ),
    );
  }

  Widget _homePages(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return HomeViewWidget();
              case 1:
                return FileViewWidget();
              case 2:
                return MessageViewWidget();
              case 3:
                return ProfileViewWidget();
              default:
                return HomeViewWidget();
            }
          },
        );
      },
    );
  }
}
