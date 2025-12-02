part of '../api_manager.dart';

class GetRequest<T extends Object> extends Request<T> {
  GetRequest({required super.uri, super.data, super.headers}) : super(method: 'GET');

  @override
  Future<Response<T>> send() {
    return ApiManager.instance.get(uri: uri);
  }
}
