import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_qrcode/universal_link_qrcode.dart';
import 'package:qpp_example/constants/qpp_contanst.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/page/home/view/home_page.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

// -----------------------------------------------------------------------------
/// 首頁 - 產品介紹
// -----------------------------------------------------------------------------
class HomePageIntroduce extends StatelessWidget {
  const HomePageIntroduce({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = context.screenStyle.isDesktop;

    return Padding(
      padding: EdgeInsets.only(
          top: isDesktopStyle
              ? 133 + kToolbarDesktopHeight
              : 48 + kToolbarMobileHeight,
          bottom: isDesktopStyle ? 113 : 73,
          left: 24,
          right: 24),
      child: Column(
        children: [
          isDesktopStyle ? const _DesktopBody() : const _MobileBody(),
          const SizedBox(height: 50),
          isDesktopStyle
              ? const Center(child: MoreAboutQPPButton())
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Body
// -----------------------------------------------------------------------------

/// Desktop樣式Body
class _DesktopBody extends StatelessWidget {
  const _DesktopBody();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        const _Info.desktop(),
        const SizedBox(width: 31),
        Expanded(
          flex: 2,
          child: Image.asset('assets/desktop-pic-kv.webp', fit: BoxFit.cover),
        ),
        const Spacer(),
      ],
    );
  }
}

/// Mobile樣式Body
class _MobileBody extends StatelessWidget {
  const _MobileBody();

  @override
  Widget build(BuildContext context) {
    return const _Info.mobile();
  }
}

// -----------------------------------------------------------------------------
/// 資訊
// -----------------------------------------------------------------------------
class _Info extends StatelessWidget {
  const _Info.desktop() : screenStyle = ScreenStyle.desktop;
  const _Info.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    return SizedBox(
      width: 555,
      child: Column(
        crossAxisAlignment: isDesktopStyle
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: isDesktopStyle
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/desktop-pic-qpp-text.svg',
                width: isDesktopStyle ? 103 : 69,
                height: isDesktopStyle ? 36 : 24,
              ),
              const SizedBox(width: 11),
              Text(
                context.tr(QppLocales.homeSection1Title),
                style: isDesktopStyle
                    ? QppTextStyles.web_44pt_Display_L_white_L
                    : QppTextStyles.web_24pt_title_L_white_L,
              )
            ],
          ),
          SizedBox(height: isDesktopStyle ? 15 : 24),
          Text(
            context.tr(QppLocales.homeSection1P),
            style: isDesktopStyle
                ? QppTextStyles.web_16pt_body_white_L
                : QppTextStyles.mobile_14pt_body_white_L,
          ),
          isDesktopStyle
              ? const SizedBox.shrink()
              : Image.asset('assets/mobile-pic-kv.webp', fit: BoxFit.cover),
          SizedBox(height: isDesktopStyle ? 61 : 56.4),
          isDesktopStyle ? const _Qrcode.desktop() : const _Qrcode.mobile(),
          SizedBox(height: isDesktopStyle ? 63 : 37),
          isDesktopStyle
              ? const _PlayStoreButtons.desktop()
              : const _PlayStoreButtons.mobile()
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
/// QRCode
// -----------------------------------------------------------------------------
/// Note: 跟slogan一起
class _Qrcode extends StatelessWidget {
  const _Qrcode.desktop() : screenStyle = ScreenStyle.desktop;
  const _Qrcode.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;
    final isDesktopStyle = screenStyle.isDesktop;
    final int flex = isDesktopStyle ? 1 : 0;

    return Flex(
      direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
      children: [
        isDesktopPlatform
            ? Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click, // 改鼠標樣式
                  child: GestureDetector(
                    onTap: () => ServerConst.appStoreUrl.launchURL(),
                    child: const QPPQRCode(
                      data: ServerConst.appStoreUrl,
                      size: 120,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        isDesktopPlatform
            ? const SizedBox(height: 30, width: 48)
            : const SizedBox.shrink(),
        Flexible(
          flex: flex,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/desktop-icon-kv-registered.svg',
                width: isDesktopStyle ? 36 : 28,
                height: isDesktopStyle ? 36 : 28,
              ),
              SizedBox(width: isDesktopStyle ? 20 : 12),
              Flexible(
                child: isDesktopStyle
                    ? const _Slogan.desktop()
                    : const _Slogan.mobile(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

// -----------------------------------------------------------------------------
/// 口號(即刻登入...)
// -----------------------------------------------------------------------------
class _Slogan extends StatelessWidget {
  const _Slogan.desktop() : screenStyle = ScreenStyle.desktop;
  const _Slogan.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;
    final normalStyle = isDesktopStyle
        ? QppTextStyles.web_24pt_title_L_bold_white_L
        : QppTextStyles.mobile_14pt_body_white_L;
    final spanStyle = isDesktopStyle
        ? QppTextStyles.web_24pt_title_L_bold_canary_yellow_L
        : QppTextStyles.mobile_14pt_body_canary_yellow_L;

    return Html(
      shrinkWrap: true,
      data: context.tr(QppLocales.homeSection1Slogan),
      style: {
        'body': Style(
          color: normalStyle.color,
          fontSize: normalStyle.fontSize != null
              ? FontSize(normalStyle.fontSize!)
              : null,
          fontWeight: normalStyle.fontWeight,
        ),
        'span': Style(
          color: spanStyle.color,
          fontSize:
              spanStyle.fontSize != null ? FontSize(spanStyle.fontSize!) : null,
          fontWeight: spanStyle.fontWeight,
        )
      },
    );
  }
}

// -----------------------------------------------------------------------------
/// 應用程式商店按鈕 for 首頁
// -----------------------------------------------------------------------------
class _PlayStoreButtons extends StatelessWidget {
  const _PlayStoreButtons.desktop() : screenStyle = ScreenStyle.desktop;
  const _PlayStoreButtons.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    return Row(
      mainAxisAlignment:
          isDesktopStyle ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        isDesktopStyle
            ? const _PlayStoreButton.desktop(type: PlayStoreType.google)
            : const _PlayStoreButton.mobile(type: PlayStoreType.google),
        SizedBox(width: isDesktopStyle ? 14 : 12),
        isDesktopStyle
            ? const _PlayStoreButton.desktop(type: PlayStoreType.apple)
            : const _PlayStoreButton.mobile(type: PlayStoreType.apple),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
/// 應用程式商店按鈕
// -----------------------------------------------------------------------------
class _PlayStoreButton extends StatefulWidget {
  const _PlayStoreButton.desktop({required this.type})
      : screenStyle = ScreenStyle.desktop;
  const _PlayStoreButton.mobile({required this.type})
      : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;
  final PlayStoreType type;

  @override
  State<_PlayStoreButton> createState() => _PlayStoreButtonState();
}

class _PlayStoreButtonState extends State<_PlayStoreButton>
    with TickerProviderStateMixin {
  bool isHover = false;

  void expandAnimation() {
    setState(() {
      isHover = true;
    });
  }

  void collapseAnimation() {
    setState(() {
      isHover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = widget.screenStyle.isDesktop;

    return Transform.scale(
      scale: isHover ? 1.05 : 1.0,
      child: InkWell(
        child: Stack(
          children: [
            Image.asset(
              widget.type.image,
              fit: BoxFit.cover,
              width: isDesktopStyle ? 174 : 157,
              height: isDesktopStyle ? 52 : 47,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: isHover ? 175 : -125,
              child: Container(
                transform: Matrix4.rotationZ(-0.8),
                width: 50,
                height: 200,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
        onHover: (isHover) => isHover ? expandAnimation() : collapseAnimation(),
        onTap: () => widget.type.url.launchURL(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
/// 更多關於QPP Button
// -----------------------------------------------------------------------------
class MoreAboutQPPButton extends StatefulWidget {
  const MoreAboutQPPButton({super.key});

  @override
  State<MoreAboutQPPButton> createState() => _MoreAboutQPPButtonState();
}

class _MoreAboutQPPButtonState extends State<MoreAboutQPPButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<Offset> _offsetTween =
      Tween(begin: const Offset(0, 0), end: const Offset(0, 15));

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            final currentContext = featureKey.currentContext;
            if (currentContext != null) {
              Scrollable.ensureVisible(currentContext,
                  duration: const Duration(seconds: 1));
            }
          },
          child: SelectionContainer.disabled(
            child: Column(
              children: [
                const Text(
                  'More About QPP',
                  style: QppTextStyles.mobile_14pt_body_white_L,
                ),
                const SizedBox(height: 5),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: _offsetTween.evaluate(_controller),
                      child: SvgPicture.asset(
                        'assets/desktop-icon-arrowdown-double.svg',
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
