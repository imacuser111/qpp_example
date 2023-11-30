import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_text/c_under_line_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        final bool isDesktopStyle = constraints.screenStyle.isDesktop;

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
    final isDesktopStyle = screenStyle.isDesktop;

    return Flex(
      direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/desktop-pic-qpp-logo-03.svg'),
        const SizedBox(height: 30, width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr(QppLocales.footerCompanyName),
              style: QppTextStyles.mobile_16pt_title_white_bold_L,
            ),
            const SizedBox(height: 20),
            Text(
              '${context.tr(QppLocales.footerTaxID)}：83527156',
              style: QppTextStyles.mobile_14pt_body_white_L,
            ),
            const SizedBox(height: 4),
            _InfoMailLinkText(
              '${context.tr(QppLocales.footerCustomerServiceEmail)}：',
              screenStyle: screenStyle,
            ),
            const SizedBox(height: 4),
            _InfoMailLinkText(
              '${context.tr(QppLocales.footerBusinessProposalEmail)}：',
              screenStyle: screenStyle,
            )
          ],
        ),
      ],
    );
  }
}

/// 資訊信箱連結Text
class _InfoMailLinkText extends StatelessWidget {
  const _InfoMailLinkText(this.text, {required this.screenStyle});

  final String text;
  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: QppTextStyles.web_14pt_body_s_white_L),
        const CUnderlineText.link(
          text: ServerConst.mailStr,
          link: ServerConst.mailUrl,
        ),
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
                text: context.tr(e.text),
                style: QppTextStyles.mobile_16pt_title_white_bold_L,
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
    const textStyle = QppTextStyles.mobile_16pt_title_white_bold_L;

    return Wrap(
      spacing: 161,
      runSpacing: runSpacing,
      children: [
        Text(context.tr(QppLocales.footerTerms), style: textStyle),
        Text(context.tr(QppLocales.footerDownload), style: textStyle)
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
    const TextStyle style = QppTextStyles.web_12pt_caption_white_L;

    return Wrap(
      spacing: 135,
      runSpacing: runSpacing,
      children: [
        CUnderlineText.link(
            text: context.tr(QppLocales.footerPrivacyPolicy),
            link: ServerConst.privacyPolicyUrl,
            style: style,
            isNewTab: true),
        const CUnderlineText.link(
            text: 'Apple Store',
            link: ServerConst.appleStoreUrl,
            style: style,
            isNewTab: true),
        CUnderlineText.link(
            text: context.tr(QppLocales.footerTermsOfService),
            link: ServerConst.termsOfUseUrl,
            style: style,
            isNewTab: true),
        const CUnderlineText.link(
            text: 'Google Play',
            link: ServerConst.googlePlayStoreUrl,
            style: style,
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
      color: QppColors.oxfordBlue,
      child: const Center(
        child: Text(
          '©2019 HOLY BUSINESS CO., LTD',
          style: QppTextStyles.web_12pt_caption_white_L,
        ),
      ),
    );
  }
}
