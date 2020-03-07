import 'package:carousel_slider/carousel_slider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/splash/SloganWidget.dart';
import 'package:treex_app/UI/widget/LOGO.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';

class FirstInitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstInitState();
}

class _FirstInitState extends State<FirstInitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: LOGOWidget(),
            ),
          ),
          Expanded(
            child: FlareActor(
              'assets/animation/treex_init.flr',
              animation: 'init',
            ),
          ),
          Container(
            height: 200,
            child: CarouselSlider.builder(
              viewportFraction: 0.7,
              aspectRatio: MediaQuery.of(context).size.width / 200,
              autoPlay: true,
              autoPlayInterval: Duration(milliseconds: 2000),
              itemBuilder: (BuildContext context, int index) {
                return SloganWidget();
              },
              itemCount: 5,
            ),
          ),
          Container(
            height: 150,
            child: Center(
              child: OutlineButton(
                onPressed: () {
                  showMIUIConfirmDialog(
                    context: context,
                    child: Container(
                      height: 300,
                      child: ListView(
                        physics: MIUIScrollPhysics(),
                        children: <Widget>[
                          ListTile(
                            trailing: Icon(Icons.storage),
                            title: Text('外部存储权限'),
                            subtitle:
                                Text('在使用过程中，本应用需要该权限用于打开您的本地文件，保存云文件无需该权限。'),
                          ),
                          ListTile(
                            trailing: Icon(MaterialCommunityIcons.network),
                            title: Text('联网权限'),
                            subtitle: Text('在使用过程中，本应用需要该权限用于连接到您的云服务。'),
                          ),
                          ListTile(
                            trailing: Icon(MaterialCommunityIcons.camera),
                            title: Text('相机权限'),
                            subtitle: Text('在使用过程中，在您允许的情况下，本应用需要该权限用于拍摄头像。'),
                          ),
                          ListTile(
                            trailing: Image.asset('assets/imgs/logo.png'),
                            title: Text('权限声明'),
                            subtitle: Text('如果您不同意调用以上权限，应用可照常运行'),
                          ),
                        ],
                      ),
                    ),
                    title: '本应用可能获取以下权限',
                    confirm: () {
                      Shared.init(context).then((shared) {
                        shared.writeFirstInit();
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    cancel: () {
                      SystemNavigator.pop();
                    },
                    cancelString: '拒绝',
                    confirmString: '同意',
                    color: Theme.of(context).appBarTheme.color,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('开启我的云生活'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
