part of '../list_controls.dart';

abstract class FilterQuery {
  List<FilterUnit> get filtersList;

  String get queryParams {
    final filtersList = this.filtersList;

    var queryParameters = '';
    for (int i = 0; i < filtersList.length; i++) {
      final filter = filtersList[i];
      final query = filter.query;

      queryParameters += query;
      if (query.isNotEmpty && i < filtersList.length - 1 && filtersList[i + 1].query.isNotEmpty) queryParameters += '&';
    }

    if (queryParameters.isNotEmpty) queryParameters = '?$queryParameters';

    return queryParameters;
  }

  Map<String, String?> get queryParametersMapped => {
    for (int i = 0; i < filtersList.length; i++) filtersList[i].key: filtersList[i].value?.toString(),
  };

  @override
  bool operator ==(Object other) {
    if (other is! FilterQuery) return false;
    if (identical(this, other)) return true;

    return listEquals(filtersList, other.filtersList);
  }

  @override
  int get hashCode => Object.hashAll(filtersList);
}
