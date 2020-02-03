import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/auth/SignUp.dart';
import 'package:treex_app/UI/widget/customWidgets.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/network/AuthUtil.dart';
import 'package:treex_app/network/Enums.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/theme/Iconfont.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _showPassword = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
            controller: _nameController,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  _nameController.clear();
                },
              ),
              labelText: '用户名',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {
                    _passwordController.clear();
                  }),
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
            onSubmitted: (value) {
              checkLogin(context);
            },
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Spacer(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  checkLogin(context);
                },
                child: Text('登录'),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).pushNamed('network');
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
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

  checkLogin(BuildContext context) {
    BotToast.showCustomLoading(toastBuilder: (_) {
      final provider = Provider.of<AppProvider>(context);
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(provider.primaryColor),
      );
    });
    AuthUtil(context)
        .checkPassword(_nameController.text, _passwordController.text)
        .then((result) {
      BotToast.closeAllLoading();
      switch (result) {
        case LoginResult.NO_USER:
          showMIUIConfirmDialog(
            context: context,
            child: SizedBox(),
            title: '创建新用户?',
            confirm: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SignUpPage(
                          userName: _nameController.text,
                          password: _passwordController.text,
                        )),
              );
            },
            cancelString: '取消',
            confirmString: '确定',
          );
          break;
        case LoginResult.SUCCESS:
          final provider = Provider.of<AppProvider>(context,listen: false);
          BotToast.showNotification(title: (_) => Text(provider.token));
          break;
        case LoginResult.PASSWORD_WRONG:
          BotToast.showNotification(title: (_) => Text('密码错误'));
          break;
      }
    });
  }
}
