part of '../../routes.dart';

class CharactersRoute extends NoTransitionRoute with $CharactersRoute {
  CharactersRoute();

  @override
  void injector(BuildContext context, GoRouterState state) {
    super.injector(context, state);
    final onlineServices = CharactersServicesNetwork();
    final localServices = CharactersServicesLocal(DatabaseHelper.instance);
    injectForce(CharactersStore(onlineServices: onlineServices, localServices: localServices));
  }

  @override
  Widget buildContent(BuildContext context, GoRouterState state) {
    return CharactersScreen();
  }
}
