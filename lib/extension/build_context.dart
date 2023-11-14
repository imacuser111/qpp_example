import 'package:flutter/material.dart';

/// BuildContext 擴充
extension BuildContextExtension on BuildContext {
  /// 是否為桌面裝置
  bool get isDesktop {
    // 運行平台
    final platform = Theme.of(this).platform;
    return switch (platform) {
      TargetPlatform.android => false,
      TargetPlatform.iOS => false,
      // 非 android / iOS 回傳 true
      _ => true,
    };
  }
}
