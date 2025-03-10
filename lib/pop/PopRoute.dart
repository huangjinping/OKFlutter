import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  PopRoute({required this.child});

  ///弹出蒙层的颜色，null则为透明
  @override
  Color get barrierColor => Colors.red;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
