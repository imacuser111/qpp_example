import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 首頁 - 頁尾
class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [_FooterInfo(), _CompanyName()]);
  }
}

/// 頁尾資訊
class _FooterInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF12162e), Color(0xFF193363)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      padding:
          const EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _info(),
          const Spacer(),
          _Guide(),
          const Spacer(),
          const LanguageDropdownMenu(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _info() {
    return Flex(direction: Axis.horizontal, children: [
      SvgPicture.asset('desktop_pic_qpp_logo_03.svg'),
      const SizedBox(height: 30, width: 30),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('快鏈科技',
            style: TextStyle(color: QppColor.white, fontSize: 16)),
        const SizedBox(height: 20),
        const Text('統一編號：83527156',
            style: TextStyle(color: QppColor.white, fontSize: 14)),
        const SizedBox(height: 5),
        _infoLinkText('客服信箱：'),
        const SizedBox(height: 5),
        _infoLinkText('商務合作信箱：')
      ]),
    ]);
  }

  /// 資訊連結Text
  Widget _infoLinkText(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: QppColor.white, fontSize: 14)),
        const CLinkText(text: 'info@qpptec.com', link: mailUrl),
      ],
    );
  }
}

class _Guide extends StatelessWidget {
  final double runSpacing = 10;

  @override
  Widget build(BuildContext context) {
    const double paddingHeight = 23;

    return Container(
      constraints: const BoxConstraints(maxWidth: 270),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _menuRow(),
        const SizedBox(height: paddingHeight),
        _titleWrap(),
        const SizedBox(height: paddingHeight),
        _links()
      ]),
    );
  }

  /// 選單按鈕(Row)
  Widget _menuRow() {
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

  /// 標題(條款、下載)
  Widget _titleWrap() {
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

  /// 連結
  Widget _links() {
    const double fontSize = 12;

    return Wrap(
      spacing: 135,
      runSpacing: runSpacing,
      children: const [
        CLinkText(
            text: '隱私權政策',
            link: privacyPolicyUrl,
            fontSize: fontSize,
            isNewTab: true),
        CLinkText(
            text: 'Apple Store',
            link: appleStoreUrl,
            fontSize: fontSize,
            isNewTab: true),
        CLinkText(
            text: '使用者條款',
            link: termsOfUseUrl,
            fontSize: fontSize,
            isNewTab: true),
        CLinkText(
            text: 'Google Play',
            link: googlePlayStoreUrl,
            fontSize: fontSize,
            isNewTab: true),
      ],
    );
  }
}

/// 公司名稱
class _CompanyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: QppColor.yaleBlue,
      child: const Center(
        child: Text(
          '©2019 HOLY BUSINESS CO., LTD',
          style: TextStyle(color: QppColor.white, fontSize: 12),
        ),
      ),
    );
  }
}
