import 'package:flutter/foundation.dart';

mixin ObjectComparator on Object {
  List<Object> get fields;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType == other.runtimeType) return false;
    if (other is! ObjectComparator) return false;
    return listEquals(fields, other.fields);
  }

  @override
  int get hashCode => Object.hashAll(fields);
}
