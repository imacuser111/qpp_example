import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/list/list.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 聯絡我們
class HomePageContact extends StatelessWidget {
  const HomePageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      // 聯絡我們的客製螢幕樣式
      final contactScreenStyle = switch (maxWidth) {
        >= 1250 => ScreenStyle.desktop,
        >= 850 && < 1250 => ScreenStyle.tablet,
        _ => ScreenStyle.mobile
      };
      final isDesktopStyle = contactScreenStyle.isDesktop;

      return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: maxWidth.determineScreenStyle().isDesktop // 換背景用一般的螢幕樣式去判斷
                  ? const AssetImage('assets/desktop-bg-area-03.webp')
                  : const AssetImage('assets/mobile-bg-area-03.webp'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: isDesktopStyle ? 152 : 72),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: _titleContent(contactScreenStyle),
              ),
              SizedBox(height: isDesktopStyle ? 45 : 60),
              _benefit(contactScreenStyle)
            ],
          ));
    });
  }

  Widget _titleContent(ScreenStyle style) {
    return switch (style) {
      ScreenStyle.mobile => const _TitleContent.mobile(),
      _ => const _TitleContent.desktop()
    };
  }

  Widget _benefit(ScreenStyle style) {
    return switch (style) {
      ScreenStyle.desktop => const _Benefit.desktop(),
      ScreenStyle.tablet => const _Benefit.tablete(),
      ScreenStyle.mobile => const _Benefit.mobile()
    };
  }
}

/// 標題內容
class _TitleContent extends StatelessWidget {
  const _TitleContent.desktop() : style = ScreenStyle.desktop;

  const _TitleContent.mobile() : style = ScreenStyle.mobile;

  final ScreenStyle style;

  @override
  Widget build(BuildContext context) {
    final bool isDesktopStyle = style.isDesktop;
    final int flex = isDesktopStyle ? 1 : 0;

    return Column(
      children: [
        Text(
          context.tr('home_digibag_title'),
          style: isDesktopStyle
              ? QppTextStyles.web_40pt_Display_m_bold_white_L
              : QppTextStyles.web_24pt_title_M_bold_white_C,
          textAlign: TextAlign.center,
        ),
        Flex(
          direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: flex,
              child: Padding(
                padding: EdgeInsets.only(
                  top: isDesktopStyle ? 30 : 50,
                  bottom: isDesktopStyle ? 0 : 11,
                ),
                child: SvgPicture.asset(
                  'assets/desktop-icon-area-04-official.svg',
                  width: isDesktopStyle ? 180 : 140,
                  height: isDesktopStyle ? 185 : 144,
                ),
              ),
            ),
            Flexible(
              flex: flex,
              child: Column(
                crossAxisAlignment: isDesktopStyle
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  _ShadowText(
                    context.tr('home_digibag_text'),
                    style: isDesktopStyle
                        ? QppTextStyles.web_40pt_Display_m_bold_canary_yellow_L
                        : QppTextStyles.web_24pt_title_L_canary_yellow_C,
                    textAlign:
                        isDesktopStyle ? TextAlign.left : TextAlign.center,
                  ),
                  isDesktopStyle
                      ? const _LinkText.desktop()
                      : const _LinkText.mobile(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 陰影文字
class _ShadowText extends StatelessWidget {
  const _ShadowText(this.text, {required this.style, required this.textAlign});

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: <Shadow>[
          Shadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: Offset.zero,
          ),
          Shadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 30,
            offset: Offset.zero,
          ),
          Shadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 40,
            offset: Offset.zero,
          )
        ],
        color: style.color,
        fontSize: style.fontSize,
      ),
      textAlign: textAlign,
    );
  }
}

/// 連結文字
class _LinkText extends StatefulWidget {
  const _LinkText.desktop() : screenStyle = ScreenStyle.desktop;

  const _LinkText.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  State<_LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<_LinkText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = widget.screenStyle.isDesktop;

    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: () => ServerConst.mailUrl.launchURL(isNewTab: false),
          onHover: (value) => setState(() {
            isHovered = value;
          }),
          child: Container(
            padding: const EdgeInsets.only(
                bottom: 3), // space between underline and text
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: QppColors.mayaBlue
                      .withOpacity(isHovered ? 1 : 0), // Text colour here
                  width: 3, // Underline width
                ),
              ),
            ),
            child: _ShadowText(
              ServerConst.mailStr,
              style: isDesktopStyle
                  ? QppTextStyles.web_40pt_Display_m_linktext_L
                  : QppTextStyles.web_24pt_title_L_link_text_C,
              textAlign: isDesktopStyle ? TextAlign.left : TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

/// 益處
class _Benefit extends StatelessWidget {
  const _Benefit.desktop() : screenStyle = ScreenStyle.desktop;
  const _Benefit.tablete() : screenStyle = ScreenStyle.tablet;
  const _Benefit.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    switch (screenStyle) {
      case ScreenStyle.desktop:
        const double space = 64;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: HomePageContactType.values
              .map(
                (e) => Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: e.contentOfTop ? 0 : space,
                        bottom: e.contentOfTop ? space : 0),
                    child: _BenefitItem(e, screenStyle: screenStyle),
                  ),
                ),
              )
              .toList(),
        );
      case ScreenStyle.tablet:
        const types = HomePageContactType.values;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: types.filterLast
                  .map(
                    (e) => Flexible(
                      child: _BenefitItem(e, screenStyle: screenStyle),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 45),
            _BenefitItem(types.last, screenStyle: screenStyle)
          ],
        );
      case ScreenStyle.mobile:
        const types = HomePageContactType.values;

        return Column(
          children: types
              .map((e) => Padding(
                    padding: EdgeInsets.only(
                      top: e == HomePageContactType.first ? 0 : 67,
                    ),
                    child: _BenefitItem(e, screenStyle: screenStyle),
                  ))
              .toList(),
        );
    }
  }
}

/// 益處Item
class _BenefitItem extends StatelessWidget {
  const _BenefitItem(this.type, {required this.screenStyle});

  final ScreenStyle screenStyle;
  final HomePageContactType type;

  @override
  Widget build(BuildContext context) {
    final bool isDesktopStyle = screenStyle.isDesktop;

    return Stack(alignment: Alignment.center, children: [
      Container(
        constraints: BoxConstraints(maxHeight: isDesktopStyle ? 307 : 230),
        child: SizedBox(
          child: SvgPicture.asset('assets/desktop_bg_area03_box.svg'),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxWidth: isDesktopStyle ? 280 : 235),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AutoSizeText(
            context.tr(type.title),
            style: isDesktopStyle
                ? QppTextStyles.web_24pt_title_L_bold_canary_yellow_L
                : QppTextStyles.web_20pt_title_m_canary_yellow_L,
          ),
          const SizedBox(height: 16),
          AutoSizeText(
            context.tr(type.directions),
            style: isDesktopStyle
                ? QppTextStyles.web_18pt_title_s_white_L
                : QppTextStyles.web_16pt_body_white_L,
          ),
        ]),
      ),
    ]);
  }
}
