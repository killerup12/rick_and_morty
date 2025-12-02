part of '../list_controls.dart';

class FilterUnit<T extends Object?> {
  FilterUnit({required this.key, required T value}) : _value = value;

  final String key;
  T _value;

  T get value => _value;
  set value(T value) => _value = value;

  String get query {
    if (value == null || value.toString().isEmpty) return '';
    return '$key=$value';
  }

  @override
  bool operator ==(Object other) {
    if (other is! FilterUnit) return false;
    if (identical(this, other)) return true;

    return key == other.key && value == other.value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}
