import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_text/c_under_line_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 頁尾
class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [_FooterInfo(), _CompanyName()]);
  }
}

/// 頁尾資訊
class _FooterInfo extends StatelessWidget {
  const _FooterInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF12162e), Color(0xFF193363)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        final bool isDesktopStyle = constraints.screenStyle.isDesktopStyle;

        return Flex(
          direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isDesktopStyle ? const Spacer() : const SizedBox.shrink(),
            isDesktopStyle
                ? const _Info(ScreenStyle.desktop)
                : const _Info(ScreenStyle.mobile),
            isDesktopStyle ? const Spacer() : const SizedBox(height: 50),
            const _Guide(),
            isDesktopStyle ? const Spacer() : const SizedBox.shrink(),
            isDesktopStyle
                ? const LanguageDropdownMenu(ScreenStyle.desktop)
                : const SizedBox.shrink(),
            isDesktopStyle ? const Spacer() : const SizedBox.shrink(),
          ],
        );
      }),
    );
  }
}

/// 資訊
class _Info extends StatelessWidget {
  const _Info(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktopStyle;

    return Flex(
      direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(isDesktopStyle
            ? 'assets/desktop_pic_qpp_logo_03.svg'
            : 'assets/mobile-pic-qpp-logo-03.svg'),
        const SizedBox(height: 30, width: 30),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('快鏈科技', style: TextStyle(color: QppColor.white, fontSize: 16)),
            SizedBox(height: 20),
            Text('統一編號：83527156',
                style: TextStyle(color: QppColor.white, fontSize: 14)),
            SizedBox(height: 5),
            _InfoLinkText('客服信箱：'),
            SizedBox(height: 5),
            _InfoLinkText('商務合作信箱：')
          ],
        ),
      ],
    );
  }
}

/// 資訊連結Text
class _InfoLinkText extends StatelessWidget {
  const _InfoLinkText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: QppColor.white, fontSize: 14)),
        const CUnderlineText.link(
            text: 'info@qpptec.com', link: ServerConst.mailUrl),
      ],
    );
  }
}

/// 導向
class _Guide extends StatelessWidget {
  const _Guide();

  @override
  Widget build(BuildContext context) {
    const double paddingHeight = 23;
    const double runSpacing = 10;

    return Container(
      constraints: const BoxConstraints(maxWidth: 270),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuButton(runSpacing: runSpacing),
          SizedBox(height: paddingHeight),
          _TitleWrap(runSpacing: runSpacing),
          SizedBox(height: paddingHeight),
          _Links(runSpacing: runSpacing)
        ],
      ),
    );
  }
}

/// 選單按鈕(Warp)
class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.runSpacing});

  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 130,
      runSpacing: runSpacing,
      children: MainMenu.values
          .map(
            (e) => MouseRegionCustomWidget(
              builder: (event) => CUnderlineText(
                text: e.value,
                fontSize: 16,
                onTap: () {
                  BuildContext? currentContext = e.currentContext;

                  if (currentContext != null) {
                    Scrollable.ensureVisible(currentContext,
                        duration: const Duration(seconds: 1));
                  }
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

/// 標題(條款、下載)
class _TitleWrap extends StatelessWidget {
  const _TitleWrap({required this.runSpacing});

  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: QppColor.white, fontSize: 16);

    return Wrap(
      spacing: 161,
      runSpacing: runSpacing,
      children: const [
        Text('條款', style: textStyle),
        Text('下載', style: textStyle)
      ],
    );
  }
}

/// 連結
class _Links extends StatelessWidget {
  const _Links({required this.runSpacing});

  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    const double fontSize = 12;

    return Wrap(
      spacing: 135,
      runSpacing: runSpacing,
      children: const [
        CUnderlineText.link(
            text: '隱私權政策',
            link: ServerConst.privacyPolicyUrl,
            fontSize: fontSize,
            isNewTab: true),
        CUnderlineText.link(
            text: 'Apple Store',
            link: ServerConst.appleStoreUrl,
            fontSize: fontSize,
            isNewTab: true),
        CUnderlineText.link(
            text: '使用者條款',
            link: ServerConst.termsOfUseUrl,
            fontSize: fontSize,
            isNewTab: true),
        CUnderlineText.link(
            text: 'Google Play',
            link: ServerConst.googlePlayStoreUrl,
            fontSize: fontSize,
            isNewTab: true),
      ],
    );
  }
}

/// 公司名稱
class _CompanyName extends StatelessWidget {
  const _CompanyName();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: QppColor.white,
      child: const Center(
        child: Text(
          '©2019 HOLY BUSINESS CO., LTD',
          style: TextStyle(color: QppColor.white, fontSize: 12),
        ),
      ),
    );
  }
}
