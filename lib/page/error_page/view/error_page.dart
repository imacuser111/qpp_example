import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_qrcode/universal_link_qrcode.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/error_page/model/error_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/constants/qpp_contanst.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

// -----------------------------------------------------------------------------
/// 錯誤頁/連動問題排除說明頁
// -----------------------------------------------------------------------------
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.type, required this.url});

  final ErrorPageType type;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktopStyle =
              screenWidthWithoutContext().determineScreenStyle().isDesktop;

          final bool isDesktopPlatform = context.isDesktopPlatform;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Flexible(
                flex: 1280,
                child: Container(
                  padding: EdgeInsets.only(
                      top: isDesktopStyle
                          ? kToolbarDesktopHeight + 100
                          : kToolbarMobileHeight + 24,
                      bottom: isDesktopStyle ? 48 : 20,
                      left: 20,
                      right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/desktop-pic-qpp-text.svg'),
                          const SizedBox(width: 12),
                          Text(
                            context.tr(QppLocales.homeSection1Title),
                            style:
                                QppTextStyles.web_40pt_Display_m_bold_white_L,
                          )
                        ],
                      ),
                      const SizedBox(height: 48),
                      isDesktopStyle
                          ? _Content.desktop(
                              type.getContentTr(context, isDesktopPlatform))
                          : _Content.mobile(
                              type.getContentTr(context, isDesktopPlatform)),
                      const SizedBox(height: 48),
                      UniversalLinkQRCode(url: url)
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
/// 內容
// -----------------------------------------------------------------------------
class _Content extends StatelessWidget {
  const _Content.desktop(this.text) : screenStyle = ScreenStyle.desktop;
  const _Content.mobile(this.text) : screenStyle = ScreenStyle.mobile;

  final String text;
  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    final bool isDesktopStyle = screenStyle.isDesktop;

    return Container(
      constraints: const BoxConstraints(minHeight: 324, maxWidth: 1280),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: QppColors.oxfordBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Flex(
            direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
            children: [
              isDesktopStyle
                  ? const Spacer(flex: 145)
                  : const SizedBox(height: 36),
              SvgPicture.asset(
                'assets/desktop-image-error.svg',
                width: isDesktopStyle ? 184 : 120,
              ),
              isDesktopStyle
                  ? const Spacer(flex: 79)
                  : const SizedBox(height: 36),
              Flexible(
                flex: isDesktopStyle ? 725 : 0,
                child:
                    Text(text, style: QppTextStyles.web_16pt_body_platinum_L),
              ),
              isDesktopStyle
                  ? const Spacer(flex: 147)
                  : const SizedBox(height: 48),
            ]),
      ),
    );
  }
}
