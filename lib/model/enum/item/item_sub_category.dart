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
    return switch (this) {
      serial => "序號",
      qrCodeOrSpecial => "QR Code",
      _ => "unknown",
    };
  }

  /// 取得 icon 路徑
  String get iconPath {
    return switch (this) {
      serial => "desktop-icon-display-scratch-card-serial-number.svg",
      qrCodeOrSpecial => "desktop-icon-display-scratch-card-qr-code.svg",
      _ => "unknown",
    };
  }
}
