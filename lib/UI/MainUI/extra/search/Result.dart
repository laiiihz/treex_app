import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/Utils/FileParseUtil.dart';
import 'package:treex_app/Utils/FileUtil.dart';
import 'package:treex_app/network/NetworkFileEntity.dart';
import 'package:treex_app/network/NetworkFileUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class ResultWidget extends StatefulWidget {
  ResultWidget({Key key, @required this.query}) : super(key: key);
  final String query;
  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<ResultWidget> with TickerProviderStateMixin {
  List<NetFileEntity> _files = [];
  List<NetFileEntity> _sharedFiles = [];
  List<FileSystemEntity> _localFiles = [];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    NetFiles netfiles = NetFiles(context);
    netfiles.search(query: widget.query, share: false).then((files) {
      setState(() {
        _files = files;
      });
    });
    netfiles.search(query: widget.query, share: true).then((files) {
      setState(() {
        _sharedFiles = files;
      });
    });
    searchInSystem() async {
      FileUtil fileUtil = await FileUtil.build(context);
      await Directory(fileUtil.appDir.path)
          .list(recursive: true)
          .forEach((item) {
        debugPrint(item.path);
        if (item.path.contains(widget.query)) _localFiles.add(item);
      });
    }

    searchInSystem().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        TabBar(
          labelColor: provider.primaryColor,
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
              _buildPrivateList(context),
              _buildSharedList(context),
              _buildLocalList(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivateList(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_files[index].name),
                leading: FileParseUtil.parseIcon(
                  name: _files[index].name,
                  isDir: _files[index].isDir,
                ),
                subtitle: Text('${FileParseUtil.parseDate(_files[index].date)}'
                    '${_files[index].isDir ? '' : '•'}'
                    '${_files[index].isDir ? '' : FileParseUtil.parseLength(_files[index].length)}'),
                onTap: () {},
              );
            },
            itemCount: _files.length,
          ),
        ),
        Container(
          height: 60,
          child: Center(
            child: Text('共找到${_files.length}个文件'),
          ),
        ),
      ],
    );
  }

  Widget _buildSharedList(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_sharedFiles[index].name),
                leading: FileParseUtil.parseIcon(
                  name: _sharedFiles[index].name,
                  isDir: _sharedFiles[index].isDir,
                ),
                subtitle: Text(
                    '${FileParseUtil.parseDate(_sharedFiles[index].date)}'
                    '${_sharedFiles[index].isDir ? '' : '•'}'
                    '${_sharedFiles[index].isDir ? '' : FileParseUtil.parseLength(_sharedFiles[index].length)}'),
                onTap: () {},
              );
            },
            itemCount: _sharedFiles.length,
          ),
        ),
        Container(
          height: 60,
          child: Center(
            child: Text('共找到${_sharedFiles.length}个文件'),
          ),
        ),
      ],
    );
  }

  Widget _buildLocalList(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_localFiles[index].path),
                onTap: () {},
              );
            },
            itemCount: _localFiles.length,
          ),
        ),
        Container(
          height: 60,
          child: Center(
            child: Text('共找到${_localFiles.length}个文件'),
          ),
        ),
      ],
    );
  }
}
