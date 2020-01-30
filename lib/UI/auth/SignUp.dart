import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/customWidgets.dart';
import 'package:treex_app/licenses/licenses.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户使用协议'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Orientation.landscape == orientation
              ? Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: buildLogo(),
                    ),
                    Expanded(child: _buildBody(context)),
                  ],
                )
              : _buildBody(context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            MediaQuery.of(context).orientation == Orientation.landscape
                ? Spacer()
                : SizedBox(),
            FlatButton(
                onPressed: () {
                  BotToast.showText(
                    text: '您拒绝本协议\n应用即将退出',
                  );
                  Future.delayed(Duration(milliseconds: 2000), () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  });
                },
                child: Text('拒绝')),
            MediaQuery.of(context).orientation == Orientation.landscape
                ? SizedBox()
                : Spacer(),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('signUpNextStep');
                },
                child: Text('同意')),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Markdown(
      data: Licenses.UserAgreement,
      physics: MIUIScrollPhysics(),
    );
  }
}
