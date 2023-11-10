import 'dart:ui';

import 'package:flutter/cupertino.dart';

enum ScreenStyle {
  mobile,
  tablet,
  desktop;

  bool get isDesktopStyle {
    return this == ScreenStyle.desktop;
  }
}

extension BoxConstraintsExtension on BoxConstraints {
  ScreenStyle get screenStyle {
    return maxWidth.determineScreenStyle();
  }
}

extension DoubleScreenExtension on double {
  /// 決定螢幕樣式
  ScreenStyle determineScreenStyle() {
    if (this < 480) {
      return ScreenStyle.mobile;
    } else if (this >= 480 && this <= 720) {
      return ScreenStyle.tablet;
    } else {
      return ScreenStyle.desktop;
    }
  }
}

extension NumScreenExtension on num {
  /// 取得真實寬度
  double getRealWidth({required double screenWidth}) {
    return screenWidth * this / 1980;
  }
}

/// 獲取當前螢幕的寬度
double screenWidthWithoutContext() {
  FlutterView window = PlatformDispatcher.instance.views.first;
  double width = window.physicalSize.width / window.devicePixelRatio;
  return width;
}