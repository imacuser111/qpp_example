import 'package:flutter/material.dart';

/// QPP 顏色定義
abstract final class QppColor {
  /// qpp basic website palette / text color
  static const Color white = Colors.white;

  /// qpp basic website palette
  static const Color spiroDiscoBall = Color(0xFF22B9FF);

  /// qpp basic website palette
  static const Color manatee = Color(0xFF959595);

  /// qpp basic website palette
  static const Color oliveDrab = Color(0xFF313131);

  /// qpp basic website palette
  static const Color laserLemon = Color(0xFFFDEB1E);

  /// qpp basic website palette
  static const Color onyx = Color(0xFF000B2B);

  /// onyx color with opacity 80%
  static Color onyx80 = QppColor.onyx.withOpacity(0.8);

  /// onyx color with opacity 60%
  static Color onyx60 = QppColor.onyx.withOpacity(0.6);

  /// qpp text color
  static const Color yaleBlue = Color(0xFF1E4287);

  /// qpp text color
  static const Color platinum = Color(0xFFD7E1EC);

  /// qpp text color
  static const Color pastelBlue = Color(0xFFB4C7DC);

  /// qpp text color
  static const Color babyBlueEyes = Color(0xFFA1CFFF);

  /// qpp text color
  static const Color mayaBlue = Color(0xFF56DFF9);

  /// qpp text color
  static const Color lapisLazuli = Color(0xFF395594);

  /// qpp text color
  static const Color indianYellow = Color(0xFFEBBC5A);

  /// qpp text color
  static const Color outrageousOrange = Color(0xFFFF6C52);

  /// qpp text color
  static const Color mediumAquamarine = Color(0xFF59FFC1);

  /// qpp bg color
  static const Color prussianBlue = Color(0xFF182855);

  /// qpp bg color
  static const Color stPatrickBlue = Color(0xFF1B3267);

  /// qpp bg color
  static const Color oxfordBlue = Color(0xFF162044);

  /// qpp line color
  static const Color cobaltBlue = Color(0xFF323DB0);
}

// Opacity(不透明度) of the color
// 100% - FF
// 95% - F2
// 90% - E6
// 85% - D9
// 80% - CC
// 75% - BF
// 70% - B3
// 65% - A6
// 60% - 99
// 55% - 8C
// 50% - 80
// 45% - 73
// 40% - 66
// 35% - 59
// 30% - 4D
// 25% - 40
// 20% - 33
// 15% - 26
// 10% - 1A
// 5% - 0D
// 0% - 00
