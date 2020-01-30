import 'package:flutter/material.dart';

class SignUpNextStepPage extends StatefulWidget {
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
