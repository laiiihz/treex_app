import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/auth/SignUp.dart';
import 'package:treex_app/UI/widget/customWidgets.dart';
import 'package:treex_app/generated/i18n.dart';
import 'package:treex_app/network/AuthUtil.dart';
import 'package:treex_app/network/Enums.dart';
import 'package:treex_app/network/NetworkAvatarOrBackground.dart';
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
  bool _nameNull = false;
  bool _passwordNull = false;
  bool _canLoginPressed = false;
  bool _passwordWrong = false;
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
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
            focusNode: _nameFocusNode,
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            onChanged: (value) {
              setState(() {
                _nameNull = value.isEmpty;
                _passwordNull = _passwordController.text.isEmpty;
                _canLoginPressed = (!_nameNull && !_passwordNull);
              });
            },
            decoration: InputDecoration(
              errorText: _nameNull ? I18n.of(context).authUserCantNull : null,
              prefixIcon: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  _nameController.clear();
                  setState(() {
                    _nameNull = true;
                    _canLoginPressed = (!_nameNull && !_passwordNull);
                  });
                },
              ),
              labelText: I18n.of(context).authUserName,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            obscureText: !_showPassword,
            onChanged: (value) {
              setState(() {
                _passwordWrong = false;
                _passwordNull = value.isEmpty;
                _nameNull = _nameController.text.isEmpty;
                _canLoginPressed = (!_nameNull && !_passwordNull);
              });
            },
            decoration: InputDecoration(
              errorText: _passwordNull
                  ? I18n.of(context).authPasswordCantNull
                  : _passwordWrong ? I18n.of(context).authPasswordWrong : null,
              prefixIcon: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {
                    _passwordController.clear();
                    setState(() {
                      _passwordWrong = false;
                      _passwordNull = true;
                      _canLoginPressed = (!_nameNull && !_passwordNull);
                    });
                  }),
              labelText: I18n.of(context).authPasswordMain,
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
                    title: (_) => Text(
                      !_showPassword
                          ? I18n.of(context).authPasswordHide
                          : I18n.of(context).authPasswordShow,
                    ),
                  );
                },
              ),
            ),
            onSubmitted: (value) {
              if (_nameController.text.isEmpty) {
                setState(() {
                  _nameNull = true;
                });
              } else {
                checkLogin(context);
              }
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
                onPressed: _canLoginPressed
                    ? () {
                        checkLogin(context);
                      }
                    : null,
                child: Text(I18n.of(context).authLogin),
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
                child: Text(I18n.of(context).authNoUserCreateQ)),
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
        .then((result) async {
      BotToast.closeAllLoading();
      switch (result) {
        case LoginResult.NO_USER:
          showMIUIConfirmDialog(
            context: context,
            child: SizedBox(),
            title: I18n.of(context).authCreateNewUserQ,
            confirm: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SignUpPage(
                          userName: _nameController.text,
                          password: _passwordController.text,
                        )),
              );
            },
          );
          break;
        case LoginResult.SUCCESS:
          final provider = Provider.of<AppProvider>(context, listen: false);
          if (provider.userProfile.avatar.isNotEmpty) {
            NetworkAvatarOrBackground(context)
                .build(provider.userProfile.avatar, FileTypeAB.AVATAR)
                .then((_) {
              NetworkAvatarOrBackground(context)
                  .build(provider.userProfile.avatar, FileTypeAB.BACKGROUND)
                  .then((_) {
                Navigator.of(context).pushReplacementNamed('home');
              });
            });
          }

          break;
        case LoginResult.PASSWORD_WRONG:
          setState(() {
            _passwordWrong = true;
          });
          BotToast.showNotification(
              title: (_) => Text(I18n.of(context).authPasswordWrong));
          break;
      }
    });
  }
}
