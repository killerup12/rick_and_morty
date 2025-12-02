part of '../route_storage.dart';

abstract interface class RouteLifeCycle {
  void init() => developer.log('$runtimeType инициализирован', level: Level.INFO.value);

  void dispose() => developer.log('$runtimeType уничтожен', level: Level.INFO.value);
}
