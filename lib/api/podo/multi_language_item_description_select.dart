import 'dart:convert';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/multi_language_item_data.dart';

class MultiLanguageItemDescriptionSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系說明資訊
class MultiLanguageItemDescriptionSelectInfoResponse extends BaseResponse {
  final MultiLanguageItemData descriptionData;

  const MultiLanguageItemDescriptionSelectInfoResponse(
      {required this.descriptionData, required super.json});

  factory MultiLanguageItemDescriptionSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemDescriptionSelectInfoResponse(
        json: json,
        descriptionData: MultiLanguageItemData.fromJson(json['description']));
  }
}
