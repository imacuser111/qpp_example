import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化對話框
///
/// Note:
/// - 基本標題與副標題，剩餘內容請帶child進來
/// - Web參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6540937b652c6e232817cf0e
/// - Mobile參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6541c1ae5d02e7233efb71d8
class CDialog extends StatelessWidget {
  const CDialog({
    super.key,
    required this.text,
    required this.subText,
    required this.child,
    required this.height,
    required this.width,
  });

  final String text;
  final String subText;
  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = !context.isDesktopPlatform;

    return Container(
      padding: EdgeInsets.only(
        top: isDesktopPlatform ? 32 : 20,
        bottom: isDesktopPlatform ? 24 : 36,
        left: isDesktopPlatform ? 36 : 24,
        right: isDesktopPlatform ? 36 : 24,
      ),
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: QppColors.prussianBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CDialogTitle(
            text: text,
            style: isDesktopPlatform
                ? QppTextStyles.web_36pt_Display_s_maya_blue_C
                : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
          ),
          SizedBox(height: isDesktopPlatform ? 32 : 17),
          Text(
            subText,
            style: isDesktopPlatform
                ? QppTextStyles.web_20pt_title_m_white_C
                : QppTextStyles.mobile_14pt_body_pastel_blue_L,
          ),
          SizedBox(height: isDesktopPlatform ? 36 : 28),
          child,
        ],
      ),
    );
  }
}

/// 對話框標題
class CDialogTitle extends StatelessWidget {
  const CDialogTitle({
    super.key,
    required this.text,
    required this.style,
    this.alignment = Alignment.center,
    this.isShowCloseButton = true,
  });

  final String text;
  final TextStyle style;
  final Alignment alignment;
  final bool isShowCloseButton;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;

    return Row(
      children: [
        alignment == Alignment.center
            ? const Spacer()
            : const SizedBox.shrink(),
        Text(text, style: style),
        Expanded(
          child: Row(
            children: [
              const Spacer(),
              isShowCloseButton
                  ? GestureDetector(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        'assets/desktop-icon-dialog-delete-normal.svg',
                        width: isDesktopPlatform ? 40 : 24,
                        height: isDesktopPlatform ? 40 : 24,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
