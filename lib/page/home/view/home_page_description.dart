import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 使用說明
class HomePageDescription extends StatelessWidget {
  const HomePageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final ScreenStyle screenStyle = constraints.screenStyle;

      return switch (screenStyle) {
        ScreenStyle.desktop => const Row(
            children: [
              Expanded(child: _PhoneDescription.desktop()),
              Expanded(child: _DirectoryAndForumDescription.desktop())
            ],
          ),
        _ => const Column(
            children: [
              _PhoneDescription.mobile(),
              _DirectoryAndForumDescription.mobile()
            ],
          ),
      };
    });
  }
}

/// 手機說明(第一區塊)
class _PhoneDescription extends StatefulWidget {
  const _PhoneDescription.desktop() : screenStyle = ScreenStyle.desktop;
  const _PhoneDescription.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  State<_PhoneDescription> createState() => _PhoneDescriptionState();
}

class _PhoneDescriptionState extends State<_PhoneDescription> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;
    final isDesktopStyle = widget.screenStyle.isDesktop;
    const type = HomePageDescriptionType.phone;

    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      child: SizedBox(
        height: isDesktopStyle ? height : height * 3 / 4,
        child: Stack(children: [
          _BgWidget(
            type,
            screenStyle: widget.screenStyle,
            isHovered: _isHovered,
          ),
          Column(children: [
            Expanded(
              flex: isDesktopStyle ? 1 : 2,
              child: Container(
                color: QppColors.barMask,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                child: Flex(
                  direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: isDesktopStyle
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SvgPicture.asset(
                        'assets/desktop-pic-qpp-logo-02.svg',
                      ),
                    ),
                    const SizedBox(height: 16, width: 36),
                    Flexible(
                      flex: isDesktopStyle ? 1 : 0,
                      child: Text(
                        context.tr(QppLocales.homeSection3Title),
                        style: isDesktopStyle
                            ? QppTextStyles.web_24pt_title_L_white_L
                            : QppTextStyles.mobile_16pt_title_white_bold_L,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isDesktopStyle
                  ? const _Content.desktop(type: type)
                  : const _Content.mobile(type: type),
            ),
          ]),
        ]),
      ),
    );
  }
}

/// 通訊錄與討論區說明(第二、三區塊)
class _DirectoryAndForumDescription extends StatelessWidget {
  const _DirectoryAndForumDescription.desktop()
      : screenStyle = ScreenStyle.desktop;
  const _DirectoryAndForumDescription.mobile()
      : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;
    final isDesktopStyle = screenStyle.isDesktop;

    return SizedBox(
      height: isDesktopStyle ? height : (height * 3 / 4) * 2,
      child: Column(children: [
        Expanded(
          child: isDesktopStyle
              ? const _Content.desktop(type: HomePageDescriptionType.directory)
              : const _Content.mobile(type: HomePageDescriptionType.directory),
        ),
        Expanded(
          child: isDesktopStyle
              ? const _Content.desktop(type: HomePageDescriptionType.forum)
              : const _Content.mobile(type: HomePageDescriptionType.forum),
        ),
      ]),
    );
  }
}

/// 內容
class _Content extends StatefulWidget {
  const _Content.desktop({required this.type})
      : screenStyle = ScreenStyle.desktop;
  const _Content.mobile({required this.type})
      : screenStyle = ScreenStyle.mobile;

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (event) => setState(() {
              _isHovered = true;
            }),
        onExit: (event) => setState(() {
              _isHovered = false;
            }),
        child: widget.screenStyle.isDesktop
            ? _DesktopStyleContent(widget.type, isHovered: _isHovered)
            : _MobileStyleContent(widget.type, isHovered: _isHovered));
  }
}

/// 桌面樣式內容
class _DesktopStyleContent extends StatelessWidget {
  const _DesktopStyleContent(this.type, {required this.isHovered});

  final HomePageDescriptionType type;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final bg = _Bg(ScreenStyle.desktop, type: type, isHovered: isHovered);

    return Row(children: [
      type.conetntOfRight ? bg : const SizedBox.shrink(),
      Expanded(
        child: Container(
          color: QppColors.oxfordBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: AutoSizeText(
                  context.tr(type.title),
                  style: QppTextStyles.web_24pt_title_L_bold_white_L,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: AutoSizeText(
                  context.tr(type.directions),
                  style: QppTextStyles.web_16pt_body_white_L,
                ),
              )
            ],
          ),
        ),
      ),
      type.conetntOfRight ? const SizedBox.shrink() : bg,
    ]);
  }
}

/// 手機樣式內容
class _MobileStyleContent extends StatelessWidget {
  const _MobileStyleContent(this.type, {required this.isHovered});

  final HomePageDescriptionType type;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Bg(ScreenStyle.mobile, type: type, isHovered: isHovered, flex: 2),
      Expanded(
        child: Container(
          color: QppColors.oxfordBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr(type.title),
                style: QppTextStyles.mobile_18pt_title_m_bold_sky_white_C,
              ),
              const SizedBox(height: 19),
              Text(
                context.tr(type.directions),
                style: QppTextStyles.mobile_14pt_body_white_C,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

class _Bg extends StatelessWidget {
  const _Bg(this.screenStyle,
      {required this.type, required this.isHovered, this.flex = 1});

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;
  final bool isHovered;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final bool isShowBackground = type != HomePageDescriptionType.phone;

    return Expanded(
      flex: (screenStyle.isDesktop || isShowBackground) ? flex : 0,
      child: _BgWidget(
        type,
        screenStyle: screenStyle,
        isHovered: isHovered,
        isShowBackground: isShowBackground,
      ),
    );
  }
}

class _BgWidget extends StatelessWidget {
  const _BgWidget(
    this.type, {
    required this.screenStyle,
    required this.isHovered,
    this.isShowBackground = true,
  });

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;
  final bool isHovered;
  final bool isShowBackground;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isShowBackground ? null : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
      child: Container(
        decoration: BoxDecoration(
          image: isShowBackground
              ? DecorationImage(
                  image: AssetImage(type.image(screenStyle)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }
}
