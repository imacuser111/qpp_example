/// 用戶驗證類型
enum VerificationType {
  /// 一般用戶
  normal(0),

  /// 官方帳號
  official(1);

  final int value;
  const VerificationType(this.value);

  factory VerificationType.findTypeByValue(int value) {
    for (var type in VerificationType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return VerificationType.normal;
  }

  /// 是否為官方帳號
  bool get isOfficial {
    return this == official;
  }

  /// 取得 icon 路徑
  String get iconPath {
    if (this == official) {
      return "desktop-icon-newsfeed-official-large.svg";
    } else {
      return "";
    }
  }
}
