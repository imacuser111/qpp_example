import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_image_dialog.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';

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

  String text(BuildContext context) {
    return switch (this) {
      CDialogActionStyle.confirm => context.tr('alert_confirm'),
      CDialogActionStyle.cancel => context.tr('alert_cancel'),
      CDialogActionStyle.logout => context.tr('alert_logout')
    };
  }

  Color get textColor {
    return switch (this) {
      CDialogActionStyle.confirm ||
      CDialogActionStyle.cancel =>
        QppColors.platinum,
      CDialogActionStyle.logout => QppColors.mayaBlue
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

/// 客製化動作對話框
///
/// Note:
/// - 基本標題與內容以及動作按鈕
/// - Web參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6540938bc2f07c20a7efe56b
/// - Mobile參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6541c1beadfd2f2035d7a2d6
class CActionsDialog extends StatelessWidget {
  const CActionsDialog({
    super.key,
    required this.text,
    required this.subText,
    required this.actions,
    required this.height,
    required this.width,
  });

  final String text;
  final String subText;
  final List<CDialogAction> actions;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;

    return Container(
      padding: EdgeInsets.only(
        top: isDesktopPlatform ? 25 : 36,
        bottom: 24,
        left: isDesktopPlatform ? 28 : 16,
        right: isDesktopPlatform ? 28 : 16,
      ),
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: QppColors.prussianBlue,
      ),
      child: Column(
        crossAxisAlignment: isDesktopPlatform
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          CDialogTitle(
            text: text,
            style: TextStyle(
              fontSize: isDesktopPlatform ? 24 : 20,
              color: QppColors.white,
            ),
            alignment:
                isDesktopPlatform ? Alignment.centerLeft : Alignment.center,
            isShowCloseButton: isDesktopPlatform,
          ),
          SizedBox(height: isDesktopPlatform ? 16 : 17),
          isDesktopPlatform
              ? UnconstrainedBox(child: Container(height: 1, width: width, color: QppColors.white))
              : const SizedBox.shrink(),
          SizedBox(height: isDesktopPlatform ? 16 : 0),
          Text(
            subText,
            style: TextStyle(
              fontSize: isDesktopPlatform ? 16 : 14,
              color: QppColors.pastelBlue,
            ),
          ),
          SizedBox(height: isDesktopPlatform ? 28 : 41),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: (isDesktopPlatform
                    ? <Widget>[const Spacer()]
                    : <Widget>[]) +
                actions
                    .map(
                      (e) => Padding(
                        padding:
                            EdgeInsets.only(left: isDesktopPlatform ? 16 : 0),
                        child: DialogActionButton(
                          style: e.style,
                          height: 44,
                          width: isDesktopPlatform ? 124 : 140,
                          onTap: e.callback,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
