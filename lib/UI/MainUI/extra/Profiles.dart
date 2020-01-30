import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LOGO.dart';

class ProfilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilesState();
}

class _ProfilesState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/imgs/nasa-1.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 40, bottom: 0, left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Hero(
                            tag: 'avatar',
                            child: Material(
                              borderRadius: BorderRadius.circular(40),
                              elevation: 10,
                              child: CircleAvatar(
                                maxRadius: 40,
                                child: Text(
                                  'L',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Hero(
                            tag: 'myName',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                'laiiihz ',
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
              CardBarWidget(child: Text('test')),
            ]),
          ),
        ],
      ),
    );
  }
}
