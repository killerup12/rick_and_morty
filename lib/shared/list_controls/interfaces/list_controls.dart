part of '../list_controls.dart';

abstract class ListControls extends FilterQuery implements Pagination {
  @override
  final FilterUnit<int> page = FilterUnit(key: 'page', value: 1);

  @override
  List<FilterUnit<Object?>> get filtersList => [page];
}
