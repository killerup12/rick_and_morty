part of '../list_controls.dart';

abstract interface class Pagination<T extends Object> {
  Pagination({required this.page});

  final FilterUnit<int> page;
}
