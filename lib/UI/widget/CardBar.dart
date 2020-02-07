import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/provider/AppProvider.dart';

class CardBarWidget extends StatefulWidget {
  CardBarWidget({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  State<StatefulWidget> createState() => _CardBarState();
}

class _CardBarState extends State<CardBarWidget> {
  @override
  Widget build(BuildContext context) {
    return CardPadding10(
      child: Card(
        shape: roundBorder10,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 100,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class CardPadding10 extends StatelessWidget {
  CardPadding10({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: provider.haveCurved ? 10 : 0,
        right: provider.haveCurved ? 10 : 0,
      ),
      child: this.child,
    );
  }
}

class TextFieldPadding extends StatelessWidget {
  TextFieldPadding({Key key, @required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: provider.haveCurved ? 15 : 5,
        right: provider.haveCurved ? 15 : 5,
      ),
      child: this.child,
    );
  }
}

EdgeInsetsGeometry cardPaddingOuter(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return EdgeInsets.only(
    left: provider.haveCurved ? 10 : 0,
    right: provider.haveCurved ? 10 : 0,
  );
}

ShapeBorder roundBorder10 = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);

EdgeInsetsGeometry edgeInsetsGeometryCurved(BuildContext context) {
  final provider = Provider.of<AppProvider>(context);
  return provider.haveCurved ? EdgeInsets.only(left: 30, right: 30) : null;
}
