import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';

class ResultWidget extends StatefulWidget {
  ResultWidget({Key key, @required this.query}) : super(key: key);
  final String query;
  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<ResultWidget> with TickerProviderStateMixin {
  List<NetFileEntity> _files = [];
  List<File> _localFiles = [];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    NetFiles(context).search(query: widget.query).then((files) {
      setState(() {
        _files = files;
      });
    });
    searchInSystem() async {
      FileUtil fileUtil = await FileUtil.build(context);
      await Directory(fileUtil.appDir.path)
          .list(recursive: true)
          .forEach((item) {
        if (item.path.contains(widget.query)) _localFiles.add(item);
      });
    }

    searchInSystem().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.cloud),
              text: '云盘',
            ),
            Tab(
              icon: Icon(Icons.share),
              text: '共享',
            ),
            Tab(
              icon: Icon(Icons.folder),
              text: '本地文件',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: MIUIScrollPhysics(),
            children: [
              ListView.builder(
                physics: MIUIScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_files[index].name),
                    leading: FileParseUtil.parseIcon(
                      name: _files[index].name,
                      isDir: _files[index].isDir,
                    ),
                    subtitle: Text(
                        '${FileParseUtil.parseDate(_files[index].date)}'
                        '${_files[index].isDir ? '' : '•'}'
                        '${_files[index].isDir ? '' : FileParseUtil.parseLength(_files[index].length)}'),
                    onTap: () {},
                  );
                },
                itemCount: _files.length,
              ),
              ListView.builder(
                physics: MIUIScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('UNDONE'),
                  );
                },
                itemCount: 1,
              ),
              ListView.builder(
                physics: MIUIScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_localFiles[index].path),
                    onTap: () {},
                  );
                },
                itemCount: _localFiles.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
