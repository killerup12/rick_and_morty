import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart' hide NoTransitionPage;

import '../pages/no_transition_page.dart';
import 'transitioned_route.dart';

abstract class NoTransitionRoute extends TransitionedRoute {
  Duration get transitionDuration => Duration.zero;
  Duration get reverseTransitionDuration => Duration.zero;

  @override
  Page<void> buildTransition(BuildContext context, GoRouterState state, Widget child) => NoTransitionPage(
    key: state.pageKey,
    name: state.name,
    transitionDuration: transitionDuration,
    reverseTransitionDuration: reverseTransitionDuration,
    child: child,
  );
}
