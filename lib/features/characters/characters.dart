import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/entities/entities.dart';
import 'package:rick_and_morty/shared/api_manager/api_manager.dart';
import 'package:rick_and_morty/shared/list_controls/list_controls.dart';
import 'package:rick_and_morty/shared/route_storage/route_storage.dart';

part 'characters.g.dart';
part 'data/characters_services.dart';
part 'data/characters_services_local.dart';
part 'data/characters_services_network.dart';
part 'domain/characters_store.dart';
part 'model/characters_filters.dart';
part 'widgets/character_card.dart';
