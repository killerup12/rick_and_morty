import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rick_and_morty/navigation/navigation.dart';
import 'package:rick_and_morty/shared/database/database.dart';

final _goRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: CharactersRoute().location,
  navigatorKey: rootNavigationKey,
  restorationScopeId: 'root',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    developer.log('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  await DatabaseHelper.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick And Morty',
      theme: .from(colorScheme: .fromSeed(seedColor: Colors.greenAccent)),
      debugShowCheckedModeBanner: false,
      scrollBehavior: _MyScrollBehavior(),
      routerConfig: _goRouter,
    );
  }
}

class _MyScrollBehavior extends ScrollBehavior {
  const _MyScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
