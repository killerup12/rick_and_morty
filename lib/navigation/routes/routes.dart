import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart' hide NoTransitionPage;
import 'package:rick_and_morty/features/characters/characters.dart';
import 'package:rick_and_morty/screens/screens.dart';
import 'package:rick_and_morty/shared/database/database.dart';

import '../transitions/transitions.dart';

part 'home_branch/characters/characters_route.dart';
part 'home_branch/favorite/favorite_route.dart';
part 'home_branch/home_route.dart';
part 'routes.g.dart';

final rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'global');
