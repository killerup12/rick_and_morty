import 'package:flutter/widgets.dart' hide RouteAware;
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/shared/route_storage/route_storage.dart';

abstract class TransitionedRoute extends GoRouteData with RouteAware, DependencyInjector {
  Widget buildContent(BuildContext context, GoRouterState state);

  Page<void> buildTransition(BuildContext context, GoRouterState state, Widget child);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    path = state.uri.path;

    return buildTransition(
      context,
      state,
      LifeCycleWidget(
        onInit: () => injector(context, state),
        onDispose: () => dispose(context, state),
        child: Builder(builder: (context) => buildContent(context, state)),
      ),
    );
  }
}

class LifeCycleWidget extends StatefulWidget {
  const LifeCycleWidget({required this.child, this.onInit, this.onDispose});

  final void Function()? onInit;
  final void Function()? onDispose;
  final Widget child;

  @override
  State<LifeCycleWidget> createState() => _LifeCycleWidgetState();
}

class _LifeCycleWidgetState extends State<LifeCycleWidget> {
  @override
  void initState() {
    widget.onInit?.call();
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
