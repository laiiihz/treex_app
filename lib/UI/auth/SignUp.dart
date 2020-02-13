import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:treex_app/UI/auth/SignUpNextStep.dart';
import 'package:treex_app/UI/widget/customWidgets.dart';
import 'package:treex_app/licenses/licenses.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    Key key,
    this.userName = '',
    this.password = '',
  }) : super(key: key);
  final String userName;
  final String password;
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  int _licensesIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户使用协议'),
        actions: <Widget>[
          IconButton(
            icon: buildLogo(),
            onPressed: () {},
          ),
        ],
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => SignUpNextStepPage(
                              userName: widget.userName,
                              password: widget.password,
                            )),
                  );
                },
                child: Text('同意')),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionPanelList(
          expansionCallback: (index, state) {
            setState(() {
              _licensesIndex = !state ? index : -1;
            });
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _licensesIndex == 0,
              headerBuilder: (context, state) {
                return ListTile(
                  title: Text('GPL'),
                );
              },
              body: Markdown(
                data: Licenses.UserAgreement,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
