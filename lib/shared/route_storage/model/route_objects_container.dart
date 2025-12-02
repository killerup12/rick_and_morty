part of '../route_storage.dart';

class RouteObjectsContainer {
  RouteObjectsContainer({required this.path, required this.objects}) {
    for (final object in objects) {
      if (object is RouteLifeCycle) object.init();
    }
  }

  final String path;
  final List<Object> objects;

  void dispose() {
    for (final object in objects) {
      if (object is RouteLifeCycle) object.dispose();
    }
  }
}
