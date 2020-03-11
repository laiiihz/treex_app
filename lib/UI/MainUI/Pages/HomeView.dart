import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/extra/AppSearchDelegate.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/widget/buildEmpty.dart';
import 'package:treex_app/UI/widget/LOGO.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HomeViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewWidget> {
  List<Widget> _displayWidget = [];
  double _offset = 0;
  @override
  void initState() {
    super.initState();
    FileUtil.build(context).then((fileUtil) async {
      List<FileSystemEntity> fileList =
          fileUtil.appDir.listSync(recursive: true);
      for (int i = 0; i < fileList.length; i++) {
        await FileSystemEntity.isDirectory(fileList[i].path)
            .then((state) async {
          if (!state) {
            switch (FileNameClass.fromName(fileList[i].path).suffix) {
              case 'webp':
              case 'jpg':
              case 'jpeg':
              case 'png':
                await decodeImageFromList(
                        File(fileList[i].path).readAsBytesSync())
                    .then((image) {
                  _displayWidget.add(
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: AspectRatio(
                        aspectRatio: image.width / image.height,
                        child: Stack(
                          children: <Widget>[
                            Image.file(fileList[i]),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text('${image.width}x${image.height}'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10)),
                                ),
                                child: Text(
                                  FileParseUtil.parseLength(
                                      File(fileList[i].path).lengthSync()),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
                break;
              default:
                Icon icon = FileParseUtil.parseIcon(
                    name: fileList[i].path, isDir: false);
                _displayWidget.add(
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: <Widget>[
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onPressed: () {},
                            color: Theme.of(context).cardColor,
                            child: Center(
                              child: Icon(
                                icon.icon,
                                color: icon.color,
                                size: 50,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              FileParseUtil.parseLocalPath(fileList[i].path),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                break;
            }
          }
        });
        if (i == (fileList.length - 1)) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (value) {
        _offset = value.position.dy;
      },
      onPointerUp: (value) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        provider.changeFABDisplay((value.position.dy - _offset) > 0);
      },
      child: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            title: LOGOWidget(),
            actions: <Widget>[
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: AppSearchDelegate());
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider.builder(
                autoPlay: true,
                height: 240,
                autoPlayCurve: Curves.easeInOutCubic,
                autoPlayInterval: Duration(milliseconds: 4000),
                itemCount: 5,
                aspectRatio: 1,
                viewportFraction: 1.0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/imgs/nasa-${index + 1}.webp',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: _displayWidget.length == 0
                ? Container(
                    height: 200,
                    child: buildEmptyNormal(
                      _displayWidget.length == 0,
                      value: '无可显示项目',
                    ),
                  )
                : SizedBox(),
          ),
          SliverToBoxAdapter(
            child: WaterfallFlow.builder(
              padding: EdgeInsets.only(bottom: 100),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverWaterfallFlowDelegate(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: _displayWidget[index],
                );
              },
              itemCount: _displayWidget.length,
            ),
          ),
        ],
      ),
    );
  }
}
