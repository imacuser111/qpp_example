// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'multi_language_item_data.g.dart';

/// 帶有多語系的回傳資料結構, 物品資訊 說明/連結
@JsonSerializable()
class MultiLanguageItemData {
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

  const MultiLanguageItemData({
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

  factory MultiLanguageItemData.fromJson(Map<String, dynamic> json) =>
      _$MultiLanguageItemDataFromJson(json);
}
