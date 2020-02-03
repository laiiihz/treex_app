import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册'),
      ),
    );
  }
}
