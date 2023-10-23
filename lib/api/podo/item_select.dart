import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'item_select.g.dart';

class ItemSelectRequest {
  String createItemSelectBody(List<int> itemIds) {
    return json.encode({'itemIds': itemIds});
  }
}

@JsonSerializable()
class ItemSelectResponse {
  const ItemSelectResponse({required this.errorCode, required this.itemList});

  final String errorCode;
  final List<dynamic> itemList;

  factory ItemSelectResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemSelectResponseFromJson(json);

  Map<String, dynamic> getData(int index) {
    return itemList[index];
  }
}
