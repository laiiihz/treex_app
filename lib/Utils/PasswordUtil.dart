import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';

class PasswordUtil {
  String _name;
  String _password;
  PasswordUtil({String name, String password}) {
    _password = password;
    _name = name;
  }
  String genPassword() {
    var digest = crypto.Hmac(crypto.sha512, utf8.encode(_password))
        .convert(utf8.encode(_name));
    return digest.toString();
  }
}
