part of '../api_manager.dart';

class Response<T extends Object> {
  Response({required this.request, this.data});

  final Request<T> request;
  final T? data;
}
