part of '../api_manager.dart';

abstract class Request<T extends Object> {
  const Request({required this.uri, required this.data, this.headers, required this.method});

  final Uri uri;
  final T? data;
  final Map<String, dynamic>? headers;
  final String method;

  Future<Response<T>> send();
}
