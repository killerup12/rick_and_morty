part of '../route_storage.dart';

mixin DependencyPermission<T extends StatefulWidget> on State<T> {
  final _cashedObjects = <Type, Object>{};
  final _routeStorage = _RouteStorage.instance;

  T getStore<T extends Object>() {
    var cashedObject = _cashedObjects[T];
    if (cashedObject == null) {
      cashedObject = _routeStorage.getStore<T>();
      _cashedObjects[T] = cashedObject;
    }
    return _routeStorage.getStore<T>();
  }
}
