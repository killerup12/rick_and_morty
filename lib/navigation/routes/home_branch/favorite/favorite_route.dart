part of '../../routes.dart';

class FavoriteRoute extends NoTransitionRoute with $FavoriteRoute {
  FavoriteRoute();

  @override
  Widget buildContent(BuildContext context, GoRouterState state) {
    return FavoriteScreen();
  }
}
