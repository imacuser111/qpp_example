import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_button/dialog_action_button.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 圖片對話框
///
/// - Web參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6540937d03ec1c207e173c1f
/// - Mobile參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6541c1b0ae8339230644ba4e
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
                style: isDesktopPlatform
                    ? QppTextStyles.web_36pt_Display_s_maya_blue_C
                    : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
              ),
            ],
          ),
          SizedBox(height: isDesktopPlatform ? 32 : 17),
          Text(
            subText,
            style: isDesktopPlatform
                ? QppTextStyles.web_20pt_title_m_white_C
                : QppTextStyles.mobile_14pt_body_pastel_blue_L,
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
