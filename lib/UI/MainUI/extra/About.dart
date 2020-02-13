import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/AuthorDisplay.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/theme/Iconfont.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  int _devToolOn = 10;
  Shared _shared;
  @override
  void initState() {
    super.initState();
    _initShred() async {
      _shared = await Shared.init(context);
    }

    _initShred();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('关于'),
              background: LargeIconBackgroundWidget(
                tag: 'about',
                icon: MaterialCommunityIcons.tree,
              ),
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text('开源许可'),
                onTap: () {
                  Navigator.of(context).pushNamed('licenses');
                },
                leading: Icon(AntDesign.codesquare),
              ),
              ListTile(
                title: Text('用户使用协议'),
                onTap: () {},
                leading: Icon(AntDesign.user),
              ),
              ListTile(
                title: Text('GPL v3'),
                onTap: () {
                  Navigator.of(context).pushNamed('licenses_gpl');
                },
                leading: Icon(AntDesign.codesquareo),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('laiiihz'),
                subtitle: Text("作者"),
                onTap: provider.devTool
                    ? () {
                        BotToast.showText(text: '已开启开发者模式');
                      }
                    : () {
                        if (_devToolOn != 0) {
                          BotToast.showText(text: '再点击$_devToolOn次开启开发者模式');
                          _devToolOn--;
                        } else {
                          _shared.writeDevTools(true);
                          provider.changeDevTool(true);
                          BotToast.showText(text: '已开启开发者模式');
                        }
                      },
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  physics: MIUIScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return AuthorDisplayWidget(
                      authorCard: authorCards[index],
                    );
                  },
                  itemCount: authorCards.length,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  List<AuthorCard> authorCards = [
    AuthorCard(
      background: Color(0xff24292E),
      text: 'Github',
      icon: Icon(AntDesign.github),
      onTap: () {
        launch('https://github.com/laiiihz');
      },
    ),
    AuthorCard(
      background: Color(0xff0884FF),
      text: '知乎',
      icon: Icon(AntDesign.zhihu),
      onTap: () {
        launch('https://zhihu.com/people/laihz');
      },
    ),
    AuthorCard(
      background: Color(0xff4CAF50),
      text: '酷安',
      icon: Transform.translate(
        offset: Offset(-10, 0),
        child: Icon(Iconfont.coolapk),
      ),
      onTap: () {
        launch('https://www.coolapk.com/u/748141', universalLinksOnly: true);
      },
    ),
  ];
}

class AuthorCard {
  Color background;
  String text;
  Widget icon;
  VoidCallback onTap;
  AuthorCard({
    this.background,
    this.text,
    this.icon,
    this.onTap,
  });
}
