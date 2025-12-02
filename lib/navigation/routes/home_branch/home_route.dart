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
class HomeRoute extends StatefulShellRouteData {
  const HomeRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
      HomeScreen(navigationShell: navigationShell);
}
