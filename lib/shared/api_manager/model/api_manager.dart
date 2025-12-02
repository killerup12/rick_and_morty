part of '../api_manager.dart';

abstract interface class ApiIntegrator {
  Future<T> get<T>({required Uri uri, Map<String, dynamic>? headers, Map<String, dynamic>? body});
  Future<T> post<T>({required Uri uri, Map<String, dynamic>? headers, Map<String, dynamic>? body});
}

class ApiManager implements ApiIntegrator {
  const ApiManager._();

  static ApiManager? _instace;

  static ApiManager get instance => _instace ??= ApiManager._();

  Future<T> _sendRequest<T>({required String method, required Uri uri, Map<String, dynamic>? headers}) async {
    developer.log('$method | ${uri.toString()}', level: Level.INFO.value);
    final client = http.Client();
    try {
      final request = http.Request(method, uri);
      if (headers != null) {
        request.headers.addAll(headers.map((key, value) => MapEntry(key, value.toString())));
      }
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('HTTP ${response.statusCode}: $responseBody');
      }

      return jsonDecode(responseBody) as T;
    } finally {
      client.close();
    }
  }

  @override
  Future<T> get<T>({required Uri uri, Map<String, dynamic>? headers, Map<String, dynamic>? body}) =>
      _sendRequest<T>(method: 'GET', uri: uri, headers: headers);

  @override
  Future<T> post<T>({required Uri uri, Map<String, dynamic>? headers, Map<String, dynamic>? body}) =>
      _sendRequest<T>(method: 'POST', uri: uri, headers: headers);
}
