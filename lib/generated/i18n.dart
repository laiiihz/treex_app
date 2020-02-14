import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "用户名"
  String get authUserName => "用户名";
  /// "用户名不能为空"
  String get authUserCantNull => "用户名不能为空";
  /// "密码"
  String get authPasswordMain => "密码";
  /// "密码不能为空"
  String get authPasswordCantNull => "密码不能为空";
  /// "密码或用户名错误"
  String get authPasswordWrong => "密码或用户名错误";
  /// "密码可见"
  String get authPasswordShow => "密码可见";
  /// "密码不可见"
  String get authPasswordHide => "密码不可见";
  /// "创建新用户？"
  String get authCreateNewUserQ => "创建新用户？";
  /// "没有账号？现在开始创建"
  String get authNoUserCreateQ => "没有账号？现在开始创建";
  /// "登录"
  String get authLogin => "登录";
  /// "连接成功"
  String get networkConnectionSuccess => "连接成功";
  /// "连接失败"
  String get networkConnectionFail => "连接失败";
  /// "保存"
  String get networkSave => "保存";
  /// "网络设置"
  String get networkSetting => "网络设置";
  /// "服务器IP或地址"
  String get networkIp => "服务器IP或地址";
  /// "服务器端口"
  String get networkPort => "服务器端口";
  /// "HTTPS"
  String get networkHttps => "HTTPS";
  /// "搜索"
  String get searchString => "搜索";
  /// "主页"
  String get bottomHome => "主页";
  /// "云盘"
  String get bottomCloud => "云盘";
  /// "消息"
  String get bottomMessage => "消息";
  /// "我"
  String get bottomProfile => "我";
  /// "共享"
  String get cloudShare => "共享";
  /// "文件"
  String get cloudFile => "文件";
  /// "类型"
  String get cloudType => "类型";
  /// "回收站"
  String get cloudRecycle => "回收站";
  /// "云盘"
  String get cloudTitle => "云盘";
  /// "消息"
  String get messageTitle => "消息";
}

class _I18n_zh_CN extends I18n {
  const _I18n_zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  /// "NAME"
  @override
  String get authUserName => "NAME";
  /// "Name can not be blank"
  @override
  String get authUserCantNull => "Name can not be blank";
  /// "PASSWORD"
  @override
  String get authPasswordMain => "PASSWORD";
  /// "Password can not be blank"
  @override
  String get authPasswordCantNull => "Password can not be blank";
  /// "Incorrect name or password"
  @override
  String get authPasswordWrong => "Incorrect name or password";
  /// "Password is visible"
  @override
  String get authPasswordShow => "Password is visible";
  /// "Password is invisible"
  @override
  String get authPasswordHide => "Password is invisible";
  /// "Create a new user?"
  @override
  String get authCreateNewUserQ => "Create a new user?";
  /// "No account?Create now"
  @override
  String get authNoUserCreateQ => "No account?Create now";
  /// "LOGIN"
  @override
  String get authLogin => "LOGIN";
  /// "Connection successed"
  @override
  String get networkConnectionSuccess => "Connection successed";
  /// "Connection failed"
  @override
  String get networkConnectionFail => "Connection failed";
  /// "SAVE"
  @override
  String get networkSave => "SAVE";
  /// "Network Settings"
  @override
  String get networkSetting => "Network Settings";
  /// "Server IP or address"
  @override
  String get networkIp => "Server IP or address";
  /// "Server port"
  @override
  String get networkPort => "Server port";
  /// "HTTPS"
  @override
  String get networkHttps => "HTTPS";
  /// "Search"
  @override
  String get searchString => "Search";
  /// "HOME"
  @override
  String get bottomHome => "HOME";
  /// "CLOUD"
  @override
  String get bottomCloud => "CLOUD";
  /// "MESSAGE"
  @override
  String get bottomMessage => "MESSAGE";
  /// "ME"
  @override
  String get bottomProfile => "ME";
  /// "Share"
  @override
  String get cloudShare => "Share";
  /// "File"
  @override
  String get cloudFile => "File";
  /// "Types"
  @override
  String get cloudType => "Types";
  /// "Recycle bin"
  @override
  String get cloudRecycle => "Recycle bin";
  /// "Cloud"
  @override
  String get cloudTitle => "Cloud";
  /// "Message"
  @override
  String get messageTitle => "Message";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("zh", "CN"),
      Locale("en", "US")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("zh_CN" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }
    else if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("zh" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}