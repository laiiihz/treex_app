import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/UI/widget/file/FilesType.dart';

class FilesTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesTypeState();
}

class _FilesTypeState extends State<FilesTypePage> {
  int _currentExpand = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('文件类型'),
              background: LargeIconBackgroundWidget(
                tag: 'filesType',
                icon: Icons.category,
              ),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: ExpansionPanelList(
              expansionCallback: (index, value) {
                setState(() {
                  _currentExpand = (value ? -1 : index);
                });
              },
              children: [
                ExpansionPanel(
                  body: genFileType(['all', 'photo', 'video', 'music']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('test'),
                    );
                  },
                  isExpanded: _currentExpand == 0,
                  canTapOnHeader: true,
                ),
                ExpansionPanel(
                  body: genFileType(
                      ['all', 'doc', 'excel', 'ppt', 'pdf', 'markdown']),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('test'),
                    );
                  },
                  isExpanded: _currentExpand == 1,
                  canTapOnHeader: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
