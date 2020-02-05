import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LOGO.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class ProfilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilesState();
}

class _ProfilesState extends State<ProfilesPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  double _avatarInitValueEdit = -50;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<AppProvider>(context, listen: false);
      _phoneController.text = provider.userProfile.phone;
      _emailController.text = provider.userProfile.email;
      _nameController.text = provider.userProfile.name;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _avatarInitValueEdit = 16;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            centerTitle: true,
            pinned: true,
            title: LOGOWidget(),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                        color: provider.userProfile.backgroundColor),
                    width: MediaQuery.of(context).size.width,
                    child: provider.userProfile.background.isEmpty
                        ? SizedBox()
                        : Image.file(
                            provider.backgroundFile,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 40, bottom: 0, left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Hero(
                                tag: 'avatar',
                                child: Material(
                                  borderRadius: BorderRadius.circular(40),
                                  elevation: 10,
                                  child: CircleAvatar(
                                    maxRadius: 40,
                                    backgroundImage: provider.avatarFile == null
                                        ? null
                                        : FileImage(provider.avatarFile),
                                    backgroundColor: isDark(context)
                                        ? null
                                        : provider.userProfile.backgroundColor,
                                    child: provider.userProfile.avatar.isEmpty
                                        ? Text(
                                            provider.userProfile.name[0],
                                            style: TextStyle(fontSize: 30),
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                curve: Curves.easeInOutCubic,
                                bottom: _avatarInitValueEdit,
                                left: 16,
                                child: Material(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Icon(Icons.edit),
                                    ),
                                    onTap: () {},
                                  ),
                                  color: Colors.transparent,
                                ),
                                duration: Duration(milliseconds: 500),
                              ),
                            ],
                          ),
                          Spacer(),
                          Hero(
                            tag: 'myName',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                '${provider.userProfile.name} ',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CardPadding10(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: TextField(
                    enabled: false,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                    ),
                  ),
                ),
              ),
              CardPadding10(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: '电话号码',
                    ),
                  ),
                ),
              ),
              CardPadding10(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: '邮箱',
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
