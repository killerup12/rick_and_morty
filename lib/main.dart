import 'package:flutter/material.dart';
import 'package:rick_and_morty/navigation/navigation.dart';

final _goRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: CharactersRoute().location,
  navigatorKey: rootNavigationKey,
  restorationScopeId: 'root',
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
