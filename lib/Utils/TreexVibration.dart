import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:vibration/vibration.dart';

class TreexVibration {
  AppProvider provider;
  TreexVibration({@required BuildContext context}) {
    provider = Provider.of<AppProvider>(context, listen: false);
  }
  fileVib({
    @required bool isList,
    @required int size,
  }) {
    if (provider.vibrationIsOpen) {
      List<int> pattern = [0, 5];
      for (int i = 0; i < (size) && i < (isList ? 8 : 24); i++) {
        pattern.add(75);
        pattern.add(5);
      }
      Vibration.vibrate(pattern: pattern);
    }
  }
}
