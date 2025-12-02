import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/bottom_sheet_page.dart';
import 'transitioned_route.dart';

mixin BottomSheetTransitionRoute on TransitionedRoute {
  @override
  Page<void> buildTransition(BuildContext context, GoRouterState state, Widget child) {
    return BottomSheetPage(key: state.pageKey, child: child);
  }
}
