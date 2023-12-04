import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_text/info_row_link_read_more_text.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'dart:ui' as ui;

/// Description Section
class NFTSectionDescription<QppNFT> extends NFTSection {
  const NFTSectionDescription({Key? key, required super.data})
      : super(key: key);

  @override
  StateDescription createState() => StateDescription();
}

class StateDescription extends StateSection {
  @override
  Widget get sectionContent => DescriptionContent(nft: widget.data);

  @override
  String get sectionTitle => 'Description';

  @override
  String get sectionTitleIconPath =>
      'assets/desktop-icon-commodity-nft-describe.svg';
}

/// 發行者
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
      // disable SelectionArea 游標
      return SelectionContainer.disabled(
        child: MouseRegion(
          // 滑鼠移進來時會改變游標圖案
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // TODO: 點擊前往發行者頁面
            },
            child: Row(
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
            ),
          ),
        ),
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
