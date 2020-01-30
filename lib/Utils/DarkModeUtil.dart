import 'package:flutter/material.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

Color darkModeBackgroundColor(BuildContext context) {
  return isDark(context) ? Color(0x33000000) : Color(0x99ffffff);
}


Color primaryBackgroundColor(BuildContext context) {
  return isDark(context) ? Color(0xff007ac1) : Color(0xff67daff);
}
