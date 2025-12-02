import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'pages.dart';

class SlideFromRightPage<T> extends CustomTransitionPage<T> {
  const SlideFromRightPage({
    required super.child,
    super.transitionDuration = kDefaultPageTransitionDuration,
    super.name,
    required super.key,
  }) : super(reverseTransitionDuration: kDefaultPageTransitionDuration, transitionsBuilder: _slideFromRightTransition);
}

Widget _slideFromRightTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final mainOffset = animation.drive(Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero));

  return SlideTransition(position: mainOffset, child: child);
}
