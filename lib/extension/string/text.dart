import 'dart:ui';
import 'package:flutter/material.dart';

// MARK: - 字串擴充
extension StringExtension on String {
  /// 計算文字Size(\n不會計算)
  Size size(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  /// 計算文字高度
  double height(TextStyle style, BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    FlutterView window = PlatformDispatcher.instance.views.first;

    final Size sizeFull = (TextPainter(
      text: TextSpan(
        text: replaceAll('\n', ''),
        style: style,
      ),
      // textScaleFactor: mediaQuery.textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;

    final numberOfLinebreaks = split('\n').length;

    final numberOfLines =
        (sizeFull.width / (window.physicalSize.width)).ceil() +
            numberOfLinebreaks;

    return sizeFull.height * numberOfLines;
  }
}