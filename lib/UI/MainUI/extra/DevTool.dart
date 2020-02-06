import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/download/downloadSystem.dart';
import 'package:treex_app/provider/AppProvider.dart';

enum _DevOp {
  GET,
  PUT,
  DELETE,
}

class DevToolPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DevToolState();
}

class _DevToolState extends State<DevToolPage> {
  _DevOp _nowOp = _DevOp.GET;
  int _nowIndex = -1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('开发者工具'),
            ),
          ),
          SliverToBoxAdapter(
            child: ExpansionPanelList(
              expansionCallback: (index, expand) {
                setState(() {
                  _nowIndex = expand ? -1 : index;
                });
              },
              children: [
                ExpansionPanel(
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CardPadding10(
                        child: TextField(
                          decoration: InputDecoration(labelText: '地址'),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          DropdownButton<_DevOp>(
                            icon: Icon(Icons.arrow_drop_down_circle),
                            underline: Container(height: 0),
                            value: _nowOp,
                            items: [
                              DropdownMenuItem(
                                child: Text('get'),
                                value: _DevOp.GET,
                              ),
                              DropdownMenuItem(
                                child: Text('put'),
                                value: _DevOp.PUT,
                              ),
                              DropdownMenuItem(
                                child: Text('delete'),
                                value: _DevOp.DELETE,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _nowOp = value;
                              });
                            },
                          ),
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          OutlineButton(
                            onPressed: () {},
                            child: Text('RESET'),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('FIRE'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('API TOOL'),
                    );
                  },
                  canTapOnHeader: true,
                  isExpanded: _nowIndex == 0,
                ),
                ExpansionPanel(
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text('Upload Test'.toUpperCase()),
                      ),
                      RaisedButton(
                        onPressed: () {
                          DownloadSystem().download(context, "./1.zip");
                        },
                        child: Text('Download Test'.toUpperCase()),
                      ),
                    ],
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('下载上传测试工具'),
                    );
                  },
                  canTapOnHeader: true,
                  isExpanded: _nowIndex == 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
