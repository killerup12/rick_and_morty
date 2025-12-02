part of '../list_controls.dart';

class ListResponse<T> {
  const ListResponse({required this.pages, required this.count, required this.response});

  final int pages;
  final int count;
  final List<T> response;

  factory ListResponse.fromJson(Map<String, dynamic> json, List<T> response) =>
      ListResponse(pages: json['info']['pages'], count: json['info']['count'], response: response);
}
