import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app/UI/widget/CardBar.dart';

class FileBackToolBarWidget extends StatefulWidget {
  FileBackToolBarWidget({
    Key key,
    this.showToolBar,
    this.goBack,
    this.nowPath,
  }) : super(key: key);
  final bool showToolBar;
  final VoidCallback goBack;
  final String nowPath;
  @override
  State<StatefulWidget> createState() => _FileBackToolBarState();
}

class _FileBackToolBarState extends State<FileBackToolBarWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: widget.showToolBar
          ? CardPadding10(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: roundBorder10,
                child: Row(
                  children: <Widget>[
                    Tooltip(
                      message: '回到上一级',
                      child: IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: widget.goBack,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: EdgeInsets.only(right: 10),
                          physics: MIUIScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Text(
                                  '  /${widget.nowPath.split('/')[index]}'),
                            );
                          },
                          itemCount: widget.nowPath.split('/').length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
