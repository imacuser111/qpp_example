// Flutter 3.0 後, 列舉可使用方式
// https://blog.logrocket.com/deep-dive-enhanced-enums-flutter-3-0/
/// 物品類別列舉
enum ItemCategory {
  unKnow(-1),

  ///0 系統_貨幣, SystemProductKind內有詳細系統貨幣資訊
  systemCoin(0),

  ///1 問券
  questionnaire(1),

  ///2 交易_委託, server用，委托單
  commission(2),

  ///9 開放授權, server用，存授權名單

  authorize(9),

  ///101 虛擬_貨幣

  virtualCoin(101),

  ///102 虛擬_寶物

  virtualTreasure(102),

  /// 103 虛擬＿寶物含標籤

  virtualTreasureWithTag(103),

  /// 201 票券_顯示

  physicalVoucher(201),

  /// 202 票券_隱藏 (序號 ＆ QR code)

  hiddenVoucher(202),

  /// 203 票卷_數位

  digitVoucher(203),

  /// 301 識別_卡片

  idCard(301),

  /// 1000 數位物品

  digitItem(1000);

  final int value;
  const ItemCategory(this.value);

  factory ItemCategory.findTypeByValue(int value) {
    for (var category in ItemCategory.values) {
      if (category.value == value) {
        return category;
      }
    }
    return ItemCategory.unKnow;
  }

  /// 取得顯示名稱
  String get displayName {
    switch (this) {
      case systemCoin:
        return "系統貨幣";
      case questionnaire:
        return "問券調查";
      case commission:
        return "交易_委託";
      case authorize:
        return "開放授權";
      case virtualCoin:
        return "數位貨幣";
      case virtualTreasure:
      case virtualTreasureWithTag:
        return "虛擬寶物";
      case physicalVoucher:
        return "實體票券";
      case hiddenVoucher:
        return "序號/QR Code";
      case digitVoucher:
        return "數位票券";
      case idCard:
        return "身份識別";
      case digitItem:
        return "數位物品";
      default:
        return "";
    }
  }

  /// 取得 icon 圖片路徑
  String get iconPath {
    switch (this) {
      case systemCoin:
      case virtualCoin:
        return "desktop-icon-display-coin.svg";
      case virtualTreasure:
      case virtualTreasureWithTag:
        return "desktop-icon-display-treasure.svg";
      case physicalVoucher:
      case digitVoucher:
        return "desktop-icon-display-ticket.svg";
      case hiddenVoucher:
        // TODO: 需判斷為 QR Code/序號
        // serial desktop-icon-display-scratch-card-serial-number.svg
        // qr code desktop-icon-display-scratch-card-qr-code.svg
        return "desktop-icon-display-scratch-card-qr-code.svg";
      case idCard:
        return "desktop-icon-display-idcard.svg";
      case digitItem:
        return "數位物品";
      case questionnaire:
      case commission:
      case authorize:
      default:
        return "";
    }
  }
}
