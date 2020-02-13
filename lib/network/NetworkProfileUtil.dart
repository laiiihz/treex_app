import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class NetworkProfileUtil extends NetworkUtilWithHeader {
  NetworkProfileUtil(BuildContext context) : super(context);

  Future<UserProfile> getProfile() async {
    Response response;
    dynamic data;

    await dio.get('/api/treex/profile').then((value) {
      response = value;
      data = response.data;
    }).catchError((err) => print(err));
    if (response == null) {
      return UserProfile();
    } else {
      return UserProfile.fromDynamic(data);
    }
  }
}

class UserProfile {
  Color backgroundColor = Colors.blue;
  String phone = "";
  String background = "";
  String name = "";
  String email = "";
  String avatar = "";
  UserProfile();
  UserProfile.fromDynamic(dynamic data) {
    this.name = data['name'];
    this.background = data['background'];
    this.backgroundColor = Color(0xff000000 + data['backgroundColor']);
    this.avatar = data['avatar'];
    this.email = data['email'];
    this.phone = data['phone'];
    print(this.backgroundColor);
  }
}
