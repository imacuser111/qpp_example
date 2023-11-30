import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化按鈕樣式
enum CButtonStyle {
  /// 長方形無邊線(Radius: 4)
  rectangle;

  double get radius => switch (this) { CButtonStyle.rectangle => 4 };
}

/// 客製化按鈕公版
class CButton extends StatelessWidget {
  /// 長方形(Radius: 4)
  const CButton.rectangle({
    super.key,
    required this.width,
    required this.height,
    this.color,
    this.border,
    required this.text,
    required this.textStyle,
    required this.onTap,
  }) : style = CButtonStyle.rectangle;

  final double width;
  final double height;
  final CButtonStyle style;
  final Color? color;
  final BoxBorder? border;
  final String text;
  final TextStyle textStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(style.radius),
        border: border,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}

/// 開啟QPP數位背包按鈕
class OpenQppButton extends StatelessWidget {
  const OpenQppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton.rectangle(
      height: 48,
      width: 154,
      color: QppColors.mayaBlue,
      text: context.tr(QppLocales.errorPageOpenQpp),
      textStyle: QppTextStyles.mobile_16pt_title_m_bold_oxford_blue_C,
      onTap: () {
        ServerConst.appStoreUrl.launchURL();
      }.throttle(),
    );
  }
}
