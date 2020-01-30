import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/customWidgets.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/theme/Iconfont.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _showPassword = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildOrientation(context),
        ],
      ),
    );
  }

  Widget _buildOrientation(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Row(
            children: <Widget>[
              Expanded(
                child: buildLogo(),
              ),
              Container(
                width: 300,
                child: ListView(
                  controller: _scrollController,
                  physics: MIUIScrollPhysics(),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: <Widget>[
                    _buildLoginForm(context),
                  ],
                ),
              ),
            ],
          );
        } else {
          return ListView(
            reverse: true,
            controller: _scrollController,
            physics: MIUIScrollPhysics(),
            padding: EdgeInsets.only(left: 20, right: 20),
            children: <Widget>[
              _buildLoginForm(context),
              buildLogo(),
            ],
          );
        }
      },
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              labelText: '用户名',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            onTap: () {
              _scrollController.animateTo(
                300,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
              );
            },
            obscureText: !_showPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: '密码',
              suffixIcon: IconButton(
                icon: AnimatedCrossFade(
                  firstChild: Icon(Icons.visibility),
                  secondChild: Icon(Icons.visibility_off),
                  crossFadeState: _showPassword
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300),
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                  BotToast.showNotification(
                    leading: (_) => !_showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    title: (_) => Text('密码${!_showPassword ? '不' : ''}可见'),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              BotToast.showCustomLoading(toastBuilder: (_) {
                final provider = Provider.of<AppProvider>(context);
                return CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(provider.primaryColor),
                );
              });
              Future.delayed(Duration(milliseconds: 1000), () {
                BotToast.closeAllLoading();
                Navigator.of(context).pushReplacementNamed('home');
              });
            },
            child: Text('登录'),
          ),
          Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('signUp');
                },
                child: Text('没有账号？现在注册')),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Iconfont.github), onPressed: () {}),
              IconButton(icon: Icon(Iconfont.wechat), onPressed: () {}),
              IconButton(icon: Icon(Iconfont.google), onPressed: () {}),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
