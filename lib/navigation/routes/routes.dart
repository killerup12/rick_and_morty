import 'package:flutter/widgets.dart' hide RouteAware;
import 'package:rick_and_morty/features/characters/characters.dart';
import 'package:rick_and_morty/navigation/navigation.dart';
import 'package:rick_and_morty/navigation/transitions/transitioned_route.dart';
import 'package:rick_and_morty/screens/screens.dart';
import 'package:rick_and_morty/shared/database/database.dart';
import 'package:rick_and_morty/shared/route_storage/route_storage.dart';

part 'home_branch/characters/characters_route.dart';
part 'home_branch/favorite/favorite_route.dart';
part 'home_branch/home_route.dart';
part 'routes.g.dart';

final rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'global');
