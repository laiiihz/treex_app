import 'package:flutter/material.dart';

/// a transparent pageRoute
class TransparentPageRoute extends PageRoute {
  TransparentPageRoute({
    @required this.builder,
    RouteSettings routeSettings,
  }) : super(
          fullscreenDialog: false,
        );
  final WidgetBuilder builder;
  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
  }

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration.zero;
}
