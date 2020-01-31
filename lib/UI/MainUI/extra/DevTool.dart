import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('开发者工具'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        physics: MIUIScrollPhysics(),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: '地址'),
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
              OutlineButton(onPressed: (){},child: Text('RESET'),),
              RaisedButton(onPressed: (){},child: Text('FIRE'),),
            ],
          ),
        ],
      ),
    );
  }
}
