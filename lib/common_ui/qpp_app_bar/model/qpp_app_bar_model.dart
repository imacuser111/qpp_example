import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_menu/c_menu_anchor.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/view/home_page.dart';

/// 主頁選單
enum MainMenu {
  /// 介紹
  introduce,

  /// 特色
  feature,

  /// 說明
  description,

  /// 聯絡我們
  contact;

  String get text {
    return switch (this) {
      MainMenu.introduce => QppLocales.menuProductIntro,
      MainMenu.feature => QppLocales.menuProductFeature,
      MainMenu.description => QppLocales.menuUsageInstruction,
      MainMenu.contact => QppLocales.menuContactUS,
    };
  }

  BuildContext? get currentContext {
    return switch (this) {
      MainMenu.introduce => introduceKey.currentContext,
      MainMenu.feature => featureKey.currentContext,
      MainMenu.description => descriptionKey.currentContext,
      MainMenu.contact => contactKey.currentContext
    };
  }
}

/// AppBar用戶資訊
enum AppBarUserInfo implements CMeunAnchorData {
  /// 登出
  logout;

  @override
  String get title {
    return switch (this) { AppBarUserInfo.logout => QppLocales.alertLogout };
  }

  @override
  String? get image => 'mobile-icon-actionbar-list-logout-pressed.svg';
}
