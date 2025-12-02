part of '../list_controls.dart';

mixin ListControlsMixin<T extends ListControls> implements ListFilters<T> {
  bool _canNotUploadMore = false;
  int _maxPages = 0;

  int get page => filters.page.value;
  int get totalPages => _maxPages;
  bool get canUploadMore => !_canNotUploadMore;

  CancelableOperation<ListResponse>? completingRequest;

  Future<void> upload();

  Future<void> refresh();

  List<R> _getResponse<R>(ListResponse<R> response) {
    filters.page.value += 1;
    _maxPages = response.pages;

    _canNotUploadMore = page >= response.pages;

    return response.response;
  }

  Future<List<R>> uploadRequest<R>(Future<ListResponse<R>> Function(T filters) callback) async {
    completingRequest?.cancel();
    completingRequest = CancelableOperation.fromFuture(callback(filters));
    final listResponse = (await completingRequest!.valueOrCancellation()) as ListResponse<R>?;
    completingRequest = null;
    if (listResponse == null) throw CanceledOperationException();

    return _getResponse(listResponse);
  }

  void toDefault() {
    _canNotUploadMore = false;
    filters.page.value = 1;
    _maxPages = 0;
  }
}
