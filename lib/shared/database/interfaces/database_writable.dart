part of '../database.dart';

abstract interface class DatabaseWritable<T> {
  Future<void> save(List<T> items);
}
