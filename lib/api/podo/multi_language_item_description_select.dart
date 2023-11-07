// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';

part 'multi_language_item_description_select.g.dart';

class MultiLanguageItemDescriptionSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系說明資訊
class MultiLanguageItemDescriptionSelectInfoResponse extends BaseResponse {
  final MultiLanguageItemDescriptionData descriptionData;

  const MultiLanguageItemDescriptionSelectInfoResponse(
      {required this.descriptionData, required super.json});

  factory MultiLanguageItemDescriptionSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemDescriptionSelectInfoResponse(
        json: json,
        descriptionData:
            MultiLanguageItemDescriptionData.fromJson(json['description']));
  }
}

@JsonSerializable()
class MultiLanguageItemDescriptionData {
  final String? CHT;
  final String? CHS;
  final String? ID;
  final String? IN;
  final String? JP;
  final String? KR;
  final String? TH;
  final String? US;
  final String? VN;
  // 預設語言
  final int defaultLanguage;
  // 是否有多語系
  final bool isMulti;
  // 物品 ID
  final int itemId;
  // 取得按鈕開啟代碼
  final int updateTime;

  const MultiLanguageItemDescriptionData({
    required this.CHT,
    required this.CHS,
    required this.ID,
    required this.IN,
    required this.JP,
    required this.KR,
    required this.TH,
    required this.US,
    required this.VN,
    required this.defaultLanguage,
    required this.isMulti,
    required this.itemId,
    required this.updateTime,
  });

  factory MultiLanguageItemDescriptionData.fromJson(
          Map<String, dynamic> json) =>
      _$MultiLanguageItemDescriptionDataFromJson(json);
}
