enum ItemSubCategory {
  unKnow(-1),
  serial(1),
  qrCodeOrSpecial(2),
  customSpecialCard(3);

  final int value;

  const ItemSubCategory(this.value);

  factory ItemSubCategory.findTypeByValue(int value) {
    for (var subCategory in ItemSubCategory.values) {
      if (subCategory.value == value) {
        return subCategory;
      }
    }
    return ItemSubCategory.unKnow;
  }

  /// 取得顯示名稱
  String get displayName {
    switch (this) {
      case serial:
        return "序號";
      case qrCodeOrSpecial:
        return "QR Code";
      default:
        return "unknown";
    }
  }

  /// 取得 icon 路徑
  String get iconPath {
    switch (this) {
      case serial:
        return "desktop-icon-display-scratch-card-serial-number.svg";
      case qrCodeOrSpecial:
        return "desktop-icon-display-scratch-card-qr-code.svg";
      default:
        return "unknown";
    }
  }
}
