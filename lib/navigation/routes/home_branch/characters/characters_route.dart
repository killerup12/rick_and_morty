part of '../../routes.dart';

class CharactersRoute extends NoTransitionRoute with $CharactersRoute {
  CharactersRoute();

  @override
  void injector(BuildContext context, GoRouterState state) {
    super.injector(context, state);
    final mockService = CharactersServicesNetwork();
    injectForce(CharactersStore(onlineServices: mockService, localServices: mockService));
  }

  @override
  Widget buildContent(BuildContext context, GoRouterState state) {
    return CharactersScreen();
  }
}
