import 'package:flutter/cupertino.dart';

/// 取得的資料對應的 語系規則
enum Language {
  /// 繁體中文
  chineseTrad("CHT"),

  /// 簡體中文
  chineseSimp("CHS"),

  /// 英文
  english("US"),

  /// 日文
  japanese("JP"),

  /// 韓文
  korean("KR"),

  /// 越南
  vietnam("VN"),

  /// 泰文
  thailand("TH"),

  /// 印尼文
  indonesia("ID");

  final String value;
  const Language(this.value);

  /// 從字串取得 Language
  factory Language.findTypeByValue(String value) {
    for (var lan in Language.values) {
      if (lan.value == value) {
        return lan;
      }
    }
    return Language.chineseTrad;
  }

  /// 從 Locale 取得 Language
  factory Language.findTypeByLocale(Locale locale) {
    for (var lan in Language.values) {
      if (lan.locale == locale) {
        return lan;
      }
    }
    return Language.chineseTrad;
  }

  /// 從定義的 index 取得 Language
  factory Language.findTypeByDefineIndex(int dIndex) {
    for (var lan in Language.values) {
      if (lan.getDefineIndex() == dIndex) {
        return lan;
      }
    }
    return Language.chineseTrad;
  }

  /// 取得定義 title
  String get displayTitle {
    return switch (this) {
      chineseTrad => '繁體中文',
      chineseSimp => '简体中文',
      english => 'English',
      japanese => '日本語',
      korean => '한국어',
      vietnam => 'Việt Nam',
      thailand => 'ภาษาไทย',
      indonesia => 'Bahasa Indonesia',
    };
  }

  /// 取得定義的 index
  int getDefineIndex() {
    return switch (this) {
      chineseTrad => 2,
      chineseSimp => 3,
      english => 1,
      japanese => 4,
      korean => 5,
      vietnam => 6,
      thailand => 7,
      indonesia => 8,
    };
  }

  /// 取得對應 Locale
  Locale get locale {
    return switch (this) {
      chineseTrad => const Locale('zh', 'TW'),
      chineseSimp => const Locale('zh', 'CN'),
      english => const Locale('en', 'US'),
      japanese => const Locale('ja', 'JP'),
      korean => const Locale('ko', 'KR'),
      vietnam => const Locale('vi', 'VN'),
      thailand => const Locale('th', 'TH'),
      indonesia => const Locale('id', 'ID'),
    };
  }
}
