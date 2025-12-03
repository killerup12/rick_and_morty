part of '../routes.dart';

class ChartersBrunchRoute extends StatefulShellBranchData {
  const ChartersBrunchRoute();
}

class FavoriteBrunchRoute extends StatefulShellBranchData {
  const FavoriteBrunchRoute();
}

@TypedStatefulShellRoute<HomeRoute>(
  branches: [
    TypedStatefulShellBranch<ChartersBrunchRoute>(routes: [TypedGoRoute<CharactersRoute>(path: '/')]),
    TypedStatefulShellBranch<FavoriteBrunchRoute>(routes: [TypedGoRoute<FavoriteRoute>(path: '/favorites')]),
  ],
)
class HomeRoute extends StatefulShellRouteData with RouteAware, DependencyInjector {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigationKey;

  @override
  void injector(BuildContext context, GoRouterState state) {
    final onlineServices = CharactersServicesNetwork();
    final localServices = CharactersServicesLocal(DatabaseHelper.instance);
    final repo = CharactersRepository(onlineServices: onlineServices, localServices: localServices);
    injectForce(CharactersStore(repository: repo));
    injectSoft(() => FavoritesStore(services: localServices));
  }

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return LifeCycleWidget(
      onInit: () {
        path = runtimeType.toString();
        injector(context, state);
      },
      onDispose: () => dispose(context, state),
      child: HomeScreen(navigationShell: navigationShell),
    );
  }
}
