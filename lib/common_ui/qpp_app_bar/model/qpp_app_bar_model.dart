/// 主頁選單
enum MainMenu {
  /// 介紹
  introduce,

  /// 特色
  feature,

  /// 說明
  description,

  /// 聯絡我們
  contact
}

extension MainMenuExtension on MainMenu {
  String get value {
    return switch (this) {
      MainMenu.introduce => '功能介紹',
      MainMenu.feature => '產品特色',
      MainMenu.description => '使用說明',
      MainMenu.contact => '聯絡我們'
    };
  }
}
