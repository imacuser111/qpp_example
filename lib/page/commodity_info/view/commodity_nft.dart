import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/mobile_info_divider.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_info_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// NFT 物品資訊
class NFTItemInfo extends StatelessWidget {
  final bool isDesktop;
  const NFTItemInfo.desktop({super.key}) : isDesktop = true;
  const NFTItemInfo.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      const CommodityBodyTop(),
      // 若為 Mobile 版面, 要顯示黑色分隔線
      MobileInfoDivider(
        isMobile: !isDesktop,
      ),
      // 資料區下半部
      Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var nft = ref.watch(itemSelectInfoProvider).nftMetaDataState.data;

          return Container(
              color: QppColors.oxfordBlue,
              constraints: const BoxConstraints(maxWidth: 1280),
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  NFTSectionDescription(
                    data: nft!,
                  ),
                  // // 類別欄位
                  // ItemInfoRow(),
                  // // 創建者欄位
                  // CreatorInfoRow(),
                  // // 連結欄位
                  // ItemIntroLinkRow(),
                  // // 說明欄位
                  // ItemDescriptionRow(),
                ],
              ));
        },
      ),
    ]);
  }
}
