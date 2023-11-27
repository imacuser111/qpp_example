import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_image/item_image.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 物品容器上半部區塊 (物品圖片, 名稱)
class CommodityBodyTop extends StatelessWidget {
  final bool isDesktop;
  const CommodityBodyTop.desktop({super.key}) : isDesktop = true;
  const CommodityBodyTop.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return // 資料區 上半部
        Container(
      margin: const EdgeInsets.only(bottom: 20),
      constraints: const BoxConstraints(maxWidth: 1280, maxHeight: 292),
      width: double.infinity,
      height: double.infinity,
      // 上半部 bg
      decoration: const _ContainerDecoration(),
      child: Column(children: [
        // 物品圖片
        const ItemImgPhoto(),
        const Expanded(child: SizedBox()),
        // 物品名稱
        Consumer(builder: (context, ref, _) {
          ApiResponse<QppItem> itemInfoState =
              ref.watch(itemSelectInfoProvider).itemSelectInfoState;
          ApiResponse<QppNFT> nftMetaState =
              ref.watch(itemSelectInfoProvider).nftMetaDataState;
          if (itemInfoState.isCompleted) {
            return Container(
              margin: const EdgeInsets.only(bottom: 26),
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                itemInfoState.data!.name,
                style: const TextStyle(fontSize: 20, color: QppColor.white),
              ),
            );
          } else if (nftMetaState.isCompleted) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                nftMetaState.data!.name,
                style: const TextStyle(fontSize: 20, color: QppColor.white),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ]),
    );
  }
}

/// 容器 Decoration
class _ContainerDecoration extends BoxDecoration {
  const _ContainerDecoration();
  @override
  DecorationImage? get image {
    return const DecorationImage(
        // 背景圖
        image: AssetImage(
            'assets/desktop-pic-commodity-largepic-sample-general.webp'),
        fit: BoxFit.none);
  }
}
