part of '../list_controls.dart';

abstract interface class ListFilters<T extends FilterQuery> {
  ListFilters(this.filters);

  final T filters;
}
