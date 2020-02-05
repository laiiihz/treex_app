import 'package:bot_toast/bot_toast.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/provider/AppProvider.dart';

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
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Text('test'),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
