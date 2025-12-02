import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NoTransitionPage<T> extends CustomTransitionPage {
  const NoTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    super.key,
  }) : super(
         transitionsBuilder: _transitionsBuilder,
         transitionDuration: transitionDuration ?? Duration.zero,
         reverseTransitionDuration: reverseTransitionDuration ?? transitionDuration ?? Duration.zero,
       );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}
