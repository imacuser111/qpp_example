import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_button/btn_arrow_up_down.dart';
import 'package:qpp_example/common_ui/qpp_text/info_row_link_read_more_text.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'dart:ui' as ui;

class NFTSectionDescription extends StatefulWidget {
  final QppNFT nft;

  const NFTSectionDescription({Key? key, required this.nft}) : super(key: key);

  @override
  StateDescription createState() => StateDescription();
}

final arrowKey = GlobalKey<StateClickArrow>();

class StateDescription extends State<NFTSectionDescription> {
  bool expanded = true;

  double inf = double.infinity;
  double zero = 0;
  double open = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NFTInfoSectionItemTitle(
        iconPath: 'assets/desktop-icon-commodity-nft-describe.svg',
        title: 'Description',
        tt: () {
          arrowKey.currentState?.rotate();
          setState(() {
            open == 0 ? 1 : 0;
            // expanded = !expanded;
          });
        },
      ),
      // 發行者
      AnimatedScale(
        scale: open,
        duration: const Duration(seconds: 1),
        child: DescriptionContent(nft: widget.nft),
      ),
      // AnimatedContainer(
      //     curve: Curves.fastOutSlowIn,
      //     duration: const Duration(seconds: 2),
      //     child: expanded
      //         ? DescriptionContent(nft: widget.nft)
      //         : const SizedBox.shrink()),
    ]);
  }
}

class DescriptionContent extends StatelessWidget {
  final QppNFT nft;

  const DescriptionContent({super.key, required this.nft});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NFTInfoRowPublisher(),
        // 連結
        NFTInfoRowIntroLink(data: nft.externalUrl),
        // 說明
        NFTInfoRowDescription(data: nft.description)
      ],
    );
  }
}

/// NFT Section title 元件
class NFTInfoSectionItemTitle extends StatelessWidget {
  // icon 路徑
  final String iconPath;
  // title
  final String title;

  final Function()? tt;

  const NFTInfoSectionItemTitle(
      {Key? key, required this.iconPath, required this.title, this.tt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final arrowKey = GlobalKey<StateClickArrow>();
    return GestureDetector(
      onTap: () {
        // arrowKey.currentState?.rotate();
        tt?.call();
      },
      child: Container(
        height: 44.0,
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        decoration: const BoxDecoration(color: QppColors.stPatricksBlue),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28.0,
              height: 28.0,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: QppTextStyles.web_18pt_title_s_pastel_blue_L,
            ),
            const Expanded(child: SizedBox()),
            // 上/下箭頭
            BtnArrowUpDown(key: arrowKey, size: 20),
          ],
        ),
      ),
    );
  }
}

/// NFT Info Row -----------------

/// 發行者資訊
class NFTInfoRowPublisher extends InfoRow {
  /// 顯示發行者
  const NFTInfoRowPublisher({super.key}) : super.desktop();

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).userInfoState;
  }

  @override
  Widget getContent(data) {
    return Builder(builder: (context) {
      return Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              context.tr(QppLocales.commodityInfoPublisher),
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_category_text_L,
            ),
          ),
          // 若為官方帳號, 顯示 icon
          data.isOfficial
              ? Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                    'assets/${data.officialIconPath}',
                    width: 20,
                  ),
                )
              : const SizedBox.shrink(),
          // id + name
          Expanded(
            child: Text(
              "${data.displayID}  ${data.displayName}",
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_Indian_yellow_L,
            ),
          ),
          // 物件左右翻轉, 或用 RotatedBox
          Directionality(
              textDirection: ui.TextDirection.rtl,
              child: SvgPicture.asset(
                'assets/mobile-icon-actionbar-back-normal.svg',
                matchTextDirection: true,
              )),
        ],
      );
    });
  }
}

/// 資訊顯示抽象類
/// 物品資訊 Row
abstract class NFTInfoRow extends StatelessWidget {
  final String data;
  const NFTInfoRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 14, 60, 14),
      child: getContent(data),
    );
  }

  Widget getContent(String data);
}

/// NFT 物品連結資訊
class NFTInfoRowIntroLink extends NFTInfoRow {
  const NFTInfoRowIntroLink({super.key, required super.data});

  @override
  Widget getContent(data) {
    // 有資料才顯示
    return Builder(builder: (context) {
      return Row(
        // 子元件對齊頂端
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              context.tr(QppLocales.commodityInfoTitle),
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_category_text_L,
            ),
          ),
          // intro link
          Expanded(
            // Expanded 包 text, 實現自動換行
            child: InfoRowLinkReadMoreText(data: data),
          ),
        ],
      );
    });
  }
}

/// NFT 物品連結資訊
class NFTInfoRowDescription extends NFTInfoRow {
  const NFTInfoRowDescription({super.key, required super.data});

  @override
  Widget getContent(data) {
    // 有資料才顯示
    return Builder(builder: (context) {
      return Row(
        // 子元件對齊頂端
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              context.tr(QppLocales.commodityInfoInfo),
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_category_text_L,
            ),
          ),
          // intro link
          Expanded(
            // Expanded 包 text, 實現自動換行
            child: InfoRowLinkReadMoreText(data: data),
          ),
        ],
      );
    });
  }
}
