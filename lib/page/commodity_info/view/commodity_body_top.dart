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
      // padding: const EdgeInsets.only(top: 0, bottom: 30),
      constraints: const BoxConstraints(maxWidth: 1280, maxHeight: 292),
      width: double.infinity,
      height: double.infinity,
      // 上半部 bg
      decoration: isDesktop ? const DesktopDecor() : const MobileDecor(),
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

class DesktopDecor extends BoxDecoration {
  const DesktopDecor();
  @override
  DecorationImage? get image {
    return const DecorationImage(
        // 背景圖
        image: AssetImage(
            'assets/desktop-pic-commodity-largepic-sample-general.webp'),
        fit: BoxFit.none);
  }
}

class MobileDecor extends BoxDecoration {
  const MobileDecor();
  @override
  DecorationImage? get image {
    return const DecorationImage(
      // TODO: 確認圖
      // centerSlice: Rect.fromLTWH(237, 140, 90, 90),
      // 背景圖
      // mobile-pic-commodity-largepic-sample-general
      image: AssetImage(
          'assets/desktop-pic-commodity-largepic-sample-general.webp'),
      fit: BoxFit.none,
    );
  }
}
