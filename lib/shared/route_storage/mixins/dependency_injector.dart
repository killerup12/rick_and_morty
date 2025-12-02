part of '../route_storage.dart';

mixin DependencyInjector on RouteData {
  final _routeStorageForDependencyInjector = _RouteStorage.instance;
  String? path;

  T injectSoft<T extends Object>(T Function() storeCreator) {
    assert(path != null, 'Требуется сначала указать маршрут');

    final existsStore = _routeStorageForDependencyInjector.getIfExists<T>();
    if (existsStore != null) return existsStore;

    final newStore = storeCreator();
    _routeStorageForDependencyInjector.addStore(path!, newStore);
    return newStore;
  }

  T injectForce<T extends Object>(T store) {
    assert(path != null, 'Требуется сначала указать маршрут');
    _routeStorageForDependencyInjector.addStore(path!, store);
    return store;
  }
}
