import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/Utils/PasswordUtil.dart';
import 'package:treex_app/network/AuthUtil.dart';
import 'package:treex_app/network/Enums.dart';

class SignUpNextStepPage extends StatefulWidget {
  SignUpNextStepPage({
    Key key,
    this.userName = '',
    this.password = '',
  }) : super(key: key);
  final String userName;
  final String password;
  @override
  State<StatefulWidget> createState() => _SignUpNextStepState();
}

class _SignUpNextStepState extends State<SignUpNextStepPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _nameNull = false;
  bool _passwordNull = false;
  bool _canSignUp = false;
  bool _nameExist = false;
  FocusNode _nameNode = new FocusNode();
  FocusNode _passwordNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    _passwordController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _canSignUp ? () => _signupFunction(context) : null,
        label: Text('注册'),
        icon: Icon(Icons.person_add),
      ),
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('用户注册'),
              background: LargeIconBackgroundWidget(
                  tag: 'logo', icon: Icons.person_pin),
            ),
            pinned: true,
            floating: true,
            stretch: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CardPadding10(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: TextField(
                    controller: _nameController,
                    focusNode: _nameNode,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          _nameController.clear();
                          _updateStates(context);
                        },
                      ),
                      labelText: '用户名',
                      errorText:
                          _nameNull ? '用户名不能为空' : _nameExist ? '用户名已存在' : null,
                    ),
                    onChanged: (value) {
                      _updateStates(context);
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordNode);
                    },
                  ),
                ),
              ),
              CardPadding10(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    focusNode: _passwordNode,
                    onChanged: (value) {
                      _updateStates(context);
                    },
                    onSubmitted: (value) {
                      if (!_nameNull && !_passwordNull)
                        _signupFunction(context);
                    },
                    decoration: InputDecoration(
                      labelText: '密码',
                      errorText: _passwordNull ? '密码不能为空' : null,
                      prefixIcon: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () {
                          _passwordController.clear();
                          _updateStates(context);
                        },
                      ),
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
                            title: (_) =>
                                Text('密码${!_showPassword ? '不' : ''}可见'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              CardPadding10(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: SelectableText('注册即代表您同意用户使用协议'),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  _updateStates(BuildContext context) {
    setState(() {
      _nameExist = false;
      _passwordNull = _passwordController.text.isEmpty;
      _nameNull = _nameController.text.isEmpty;
      _canSignUp = (!_passwordNull && !_nameNull);
    });
  }

  _signupFunction(BuildContext context) {
    BotToast.showCustomLoading(
        toastBuilder: (_) => CircularProgressIndicator());
    AuthUtil(context)
        .signup(
      name: _nameController.text,
      password: PasswordUtil(
        name: _nameController.text,
        password: _passwordController.text,
      ).genPassword(),
    )
        .then((value) {
      BotToast.closeAllLoading();
      switch (value) {
        case SignupResult.HAVE_USER:
          BotToast.showNotification(title: (_) => Text('用户已存在'));
          setState(() {
            _nameExist = true;
          });
          break;
        case SignupResult.FAIL:
          BotToast.showNotification(
            title: (_) => Text('未知错误'),
            trailing: (_) => Icon(Icons.clear, color: Colors.red),
          );
          break;
        case SignupResult.PASSWORD_NULL:
          break;
        case SignupResult.SUCCESS:
          Navigator.of(context).pop();
          BotToast.showNotification(
            title: (_) => Text('注册成功'),
            trailing: (_) => Icon(Icons.check_circle, color: Colors.green),
          );
          break;
      }
    });
  }
}
