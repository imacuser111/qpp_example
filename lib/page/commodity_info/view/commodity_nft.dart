import 'package:flutter/widgets.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';

/// 一般物品資訊
class NFTItemInfo extends StatelessWidget {
  const NFTItemInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      // 資料區 上半部
      CommodityBodyTop(),
      // 資料區下半部
      // Container(
      //     constraints: const BoxConstraints(maxWidth: 1280),
      //     width: double.infinity,
      //     padding: const EdgeInsets.only(bottom: 20),
      //     child: const Column(
      //       children: [
      //         // 類別欄位
      //         ItemInfoRow(),
      //         // 創建者欄位
      //         CreatorInfoRow(),
      //         // 連結欄位
      //         ItemIntroLinkRow(),
      //         // 說明欄位
      //         ItemDescriptionRow(),
      //       ],
      //     )),
    ]);
  }
}
