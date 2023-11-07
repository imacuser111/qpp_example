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

/// 語系
enum Language {
  /// 繁體中文
  chineseTrad,

  /// 簡體中文
  chineseSimp,

  /// 英文
  english,

  /// 日文
  japanese,

  /// 韓文
  korean,

  /// 越南
  vietnam,

  /// 泰文
  thailand,

  /// 印尼文
  indonesia
}

extension LanguageExtension on Language {
  String get value {
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
