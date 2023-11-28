import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_actions_dialog.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 圖片對話框
class CImageDialog extends StatelessWidget {
  const CImageDialog({
    super.key,
    required this.image,
    required this.text,
    required this.subText,
    this.style = CDialogActionStyle.confirm,
    required this.height,
    required this.width,
  });

  final String image;
  final String text;
  final String subText;
  final CDialogActionStyle style;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bool isDesktopPlatform = context.isDesktopPlatform;

    return Container(
      padding: EdgeInsets.only(
          top: isDesktopPlatform ? 56 : 32,
          bottom: isDesktopPlatform ? 56 : 24,
          left: isDesktopPlatform ? 130 : 16,
          right: isDesktopPlatform ? 130 : 16),
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: QppColors.prussianBlue,
      ),
      child: Column(
        children: [
          Flex(
            direction: isDesktopPlatform ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image, height: 119, width: 180),
              const SizedBox(height: 36, width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: isDesktopPlatform ? 36 : 20,
                  color: QppColors.mayaBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktopPlatform ? 32 : 17),
          Text(
            subText,
            style: TextStyle(
              fontSize: isDesktopPlatform ? 20 : 14,
              color: isDesktopPlatform ? QppColors.white : QppColors.pastelBlue,
            ),
            textAlign: TextAlign.center,
            maxLines: 2, // 沒有設定這行就不會自動換行，待研究
          ),
          SizedBox(height: isDesktopPlatform ? 48 : 39),
          DialogActionButton(
            style: style,
            height: isDesktopPlatform ? 64 : 44,
            width: isDesktopPlatform ? 480 : 295,
            onTap: () => context.pop(),
          ),
        ],
      ),
    );
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
    final isDesktopPlatform = context.isDesktopPlatform;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: style.borderColor),
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            style.text(context),
            style: TextStyle(
              fontSize: isDesktopPlatform ? 20 : 16,
              color: style.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
