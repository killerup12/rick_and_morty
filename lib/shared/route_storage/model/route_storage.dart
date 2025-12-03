part of '../route_storage.dart';

class _RouteStorage {
  _RouteStorage._();

  static final _instance = _RouteStorage._();

  static _RouteStorage get instance => _instance;

  final _routeStores = <RouteObjectsContainer>[];

  List<RouteObjectsContainer> get stores => List.unmodifiable(_routeStores);

  T getStore<T extends Object>() {
    final object = getIfExists<T>();

    assert(object != null, 'Не удалось найти $T в RouteStorage! Проверьте injector!');
    return object!;
  }

  T? getIfExists<T extends Object>() {
    final routeStores = _instance._routeStores;
    for (int i = routeStores.length - 1; i >= 0; i--) {
      final routeStore = routeStores[i];

      for (int j = routeStore.objects.length - 1; j >= 0; j--) {
        final store = routeStore.objects[j];

        if (store is T) return store;
      }
    }

    return null;
  }

  List<T> getAllExists<T extends Object>() {
    final object = <T>[];

    final routeStores = _instance._routeStores;
    for (int i = routeStores.length - 1; i >= 0; i--) {
      final routeStore = routeStores[i];

      for (int j = routeStore.objects.length - 1; j >= 0; j--) {
        final store = routeStore.objects[j];

        if (store is! T) continue;
        object.add(store);
      }
    }

    return object;
  }

  void addStore(String path, Object object) {
    for (var i = _routeStores.length - 1; i >= 0; i--) {
      final routeStore = _routeStores[i];
      if (routeStore.path != path) continue;

      routeStore.add(object);
      return;
    }

    _routeStores.add(RouteObjectsContainer(path: path, objects: [object]));
  }

  RouteObjectsContainer? storesByPath(String path) {
    for (var i = _routeStores.length - 1; i >= 0; i--) {
      final routeStore = _routeStores[i];
      if (routeStore.path == path) return routeStore;
    }

    return null;
  }

  void removePath(String path) {
    for (var i = _routeStores.length - 1; i >= 0; i--) {
      final routeStore = _routeStores[i];

      if (routeStore.path != path) continue;
      _routeStores.remove(routeStore..dispose());
    }
  }
}
