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

  String get displayTitle {
    return switch (this) {
      Language.chineseTrad => '繁體中文',
      Language.chineseSimp => '简体中文',
      Language.english => 'English',
      Language.japanese => '日本語',
      Language.korean => '한국어',
      Language.vietnam => 'Việt Nam',
      Language.thailand => 'ภาษาไทย',
      Language.indonesia => 'Bahasa Indonesia',
    };
  }
}
