import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化對話框動作
class CDialogAction {
  const CDialogAction({required this.style, required this.callback});

  final CDialogActionStyle style;
  final void Function()? callback;
}

enum CDialogActionStyle {
  /// 確定
  confirm,

  /// 取消
  cancel,

  /// 登出
  logout;

  String text(BuildContext context) => switch (this) {
        CDialogActionStyle.confirm => context.tr('alert_confirm'),
        CDialogActionStyle.cancel => context.tr('alert_cancel'),
        CDialogActionStyle.logout => context.tr('alert_logout')
      };

  TextStyle textstyle(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;

    return switch (this) {
      CDialogActionStyle.confirm ||
      CDialogActionStyle.cancel =>
        isDesktopPlatform
            ? QppTextStyles.web_20pt_title_m_white_C
            : QppTextStyles.mobile_16pt_title_white_bold_L,
      CDialogActionStyle.logout => QppTextStyles.web_16pt_body_maya_blue_R
    };
  }

  Color get borderColor {
    return switch (this) {
      CDialogActionStyle.confirm ||
      CDialogActionStyle.cancel =>
        QppColors.darkPastelBlue,
      CDialogActionStyle.logout => QppColors.mayaBlue
    };
  }
}

/// 對話框動作按鈕
class DialogActionButton extends StatelessWidget {
  const DialogActionButton({
    super.key,
    required this.style,
    required this.height,
    required this.width,
    this.onTap,
  });

  final CDialogActionStyle style;
  final double height;
  final double width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CButton.rectangle(
        width: width,
        height: height,
        border: Border.all(color: style.borderColor),
        text: style.text(context),
        textStyle: style.textstyle(context),
        onTap: onTap);
  }
}
