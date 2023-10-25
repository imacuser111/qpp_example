import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';

part 'multi_language_item_intro_link_select.g.dart';

class MultiLanguageItemIntroLinkSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系連結資訊
class MultiLanguageItemIntroLinkSelectInfoResponse extends BaseResponse {
  final MultiLanguageItemIntroLinkData introLinkData;

  const MultiLanguageItemIntroLinkSelectInfoResponse(
      {required this.introLinkData, required super.json});

  factory MultiLanguageItemIntroLinkSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemIntroLinkSelectInfoResponse(
        json: json,
        introLinkData:
            MultiLanguageItemIntroLinkData.fromJson(json['introLink']));
  }
}

@JsonSerializable()
class MultiLanguageItemIntroLinkData {
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

  const MultiLanguageItemIntroLinkData({
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

  factory MultiLanguageItemIntroLinkData.fromJson(Map<String, dynamic> json) =>
      _$MultiLanguageItemIntroLinkDataFromJson(json);
}
