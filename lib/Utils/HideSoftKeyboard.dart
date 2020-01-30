import 'package:flutter/material.dart';

/// hide soft Keyboard.
hideSoftKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
