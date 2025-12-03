part of '../../routes.dart';

class CharactersRoute extends NoTransitionRoute with $CharactersRoute {
  @override
  Widget buildContent(BuildContext context, GoRouterState state) {
    return CharactersScreen();
  }
}
