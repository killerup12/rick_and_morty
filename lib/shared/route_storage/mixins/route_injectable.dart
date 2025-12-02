part of '../route_storage.dart';

mixin RouteInjectable on Object implements RouteLifeCycle {
  @override
  void init() => developer.log('$runtimeType инициализирован', level: Level.INFO.value);

  @override
  void dispose() => developer.log('$runtimeType уничтожен', level: Level.INFO.value);
}
