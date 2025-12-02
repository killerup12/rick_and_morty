part of '../database.dart';

abstract interface class DatabaseWritable<T> {
  Future<void> save(List<T> items);

  Future<void> delete(List<T> items);

  Future<void> clear();
}
