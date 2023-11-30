import 'package:flutter/material.dart';
import 'package:qpp_example/utils/screen.dart';

/// BuildContext 擴充
extension BuildContextExtension on BuildContext {
  /// 是否為桌面裝置平台
  bool get isDesktopPlatform {
    // 運行平台
    final platform = Theme.of(this).platform;
    return switch (platform) {
      TargetPlatform.android => false,
      TargetPlatform.iOS => false,
      // 非 android / iOS 回傳 true
      _ => true,
    };
  }

  /// 螢幕樣式
  ScreenStyle get screenStyle =>
      MediaQuery.of(this).size.width.determineScreenStyle();
}
