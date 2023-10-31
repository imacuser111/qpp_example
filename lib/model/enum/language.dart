/// 語系
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

  factory Language.findTypeByValue(String value) {
    for (var lan in Language.values) {
      if (lan.value == value) {
        return lan;
      }
    }
    return Language.chineseTrad;
  }

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
}
