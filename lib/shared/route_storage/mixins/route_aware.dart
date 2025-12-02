part of '../route_storage.dart';

mixin RouteAware on RouteData {
  final _routeStorage = _RouteStorage.instance;
  String? path;

  void injector(BuildContext context, GoRouterState state) {
    path = state.uri.path;
  }

  void dispose(BuildContext context, GoRouterState state) =>
      _routeStorage.removePath(state.uri.path);
}