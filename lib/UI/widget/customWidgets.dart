import 'package:flutter/material.dart';

Widget buildLogo() {
  return Hero(
    tag: 'logo',
    child: Image.asset(
      'assets/imgs/logo.png',
      height: 200,
      width: 200,
    ),
  );
}
