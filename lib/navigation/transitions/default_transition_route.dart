import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:flutter/material.dart' show MaterialPage, Theme;
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'transitioned_route.dart';

abstract class DefaultTransitionRoute extends TransitionedRoute {
  @override
  Page<void> buildTransition(BuildContext context, GoRouterState state, Widget child) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoPage(
        key: state.pageKey,
        child: child,
      );
    }
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
