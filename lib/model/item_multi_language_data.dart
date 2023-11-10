// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/api/podo/multi_language_item_data.dart';
import 'package:qpp_example/extension/string/text.dart';

class ItemMultiLanguageData {
  late final String CHT;
  late final String CHS;
  late final String ID;
  late final String IN;
  late final String JP;
  late final String KR;
  late final String TH;
  late final String US;
  late final String VN;
  // 預設語言
  late int defaultLanguage;
  // 是否有多語系
  late bool isMulti;
  // 物品 ID
  late int itemId;
  // 取得按鈕開啟代碼
  late int updateTime;

  // TODO: 連結跟說明的初始化先分開, 若確定不需要判斷類別再統一一個
  ItemMultiLanguageData.link(MultiLanguageItemData data) {
    _create(data);
  }

  ItemMultiLanguageData.description(MultiLanguageItemData data) {
    _create(data);
  }

  _create(MultiLanguageItemData data) {
    CHT = (data.CHT.isNullOrEmpty ? "" : data.CHT)!;
    CHS = (data.CHS.isNullOrEmpty ? "" : data.CHS)!;
    ID = (data.ID.isNullOrEmpty ? "" : data.ID)!;
    IN = (data.IN.isNullOrEmpty ? "" : data.IN)!;
    JP = (data.JP.isNullOrEmpty ? "" : data.JP)!;
    KR = (data.KR.isNullOrEmpty ? "" : data.KR)!;
    TH = (data.TH.isNullOrEmpty ? "" : data.TH)!;
    US = (data.US.isNullOrEmpty ? "" : data.US)!;
    VN = (data.VN.isNullOrEmpty ? "" : data.VN)!;
    defaultLanguage = data.defaultLanguage;
    isMulti = data.isMulti;
    itemId = data.itemId;
    updateTime = data.updateTime;
  }

  /// 取得目前本地語系資訊內容, 若為空值會取預設語系資料
  String getContentWithContext(BuildContext context) {
    Locale locale = context.locale;
    return getContentWithLocale(locale);
  }

  /// 取得目前本地語系資訊內容, 若為空值會取預設語系資料
  String getContentWithLocale(Locale locale) {
    String des = switch (locale.countryCode) {
      "US" => US,
      "TW" => CHT,
      'CN' => CHS,
      'VN' => VN,
      'JP' => JP,
      'KR' => KR,
      'TH' => TH,
      'ID' => ID,
      _ => '',
    };
    return des.isNullOrEmpty ? defaultContent : des;
  }

  /// 取得預設語系資料
  String get defaultContent {
    return switch (defaultLanguage) {
      1 => US,
      2 => CHT,
      3 => CHS,
      4 => JP,
      5 => KR,
      6 => VN,
      7 => TH,
      8 => ID,
      9 => IN,
      _ => '',
    };
  }

  /// 是否有資料
  bool get hasContent {
    return !defaultContent.isNullOrEmpty;
  }
}
