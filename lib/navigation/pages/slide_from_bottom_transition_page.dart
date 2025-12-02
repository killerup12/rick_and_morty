import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages.dart';

class SlideFromBottomTransitionPage<T> extends CustomTransitionPage<T> {
  SlideFromBottomTransitionPage({
    required Widget child,
    super.name,
    required super.key,
    super.arguments,
    super.fullscreenDialog,
    super.maintainState,
    super.opaque,
    super.restorationId,
    super.reverseTransitionDuration = kDefaultPageTransitionDuration,
    super.transitionDuration = kDefaultPageTransitionDuration,
    super.barrierDismissible,
    super.barrierLabel,
  }) : super(
         child: Material(child: SafeArea(left: false, right: false, bottom: false, child: child)),
         transitionsBuilder: _slideFromBottomTransition,
       );
}

Widget _slideFromBottomTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final mainOffset = animation.drive(Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero));
  final secondaryOffset = secondaryAnimation.drive(Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)));
  return SlideTransition(
    position: mainOffset,
    child: SlideTransition(position: secondaryOffset, child: child),
  );
}
