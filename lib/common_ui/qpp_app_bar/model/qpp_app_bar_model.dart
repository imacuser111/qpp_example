import 'package:flutter/material.dart';
import 'package:qpp_example/page/qpp_home/view/qpp_home_page.dart';

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
      MainMenu.introduce => '產品介紹',
      MainMenu.feature => '產品特色',
      MainMenu.description => '使用說明',
      MainMenu.contact => '聯絡我們'
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