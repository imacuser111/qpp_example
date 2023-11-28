import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_button/btn_arrow_up_down.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// NFT 物品資訊
class NFTItemInfo extends StatelessWidget {
  final bool isDesktop;
  const NFTItemInfo.desktop({super.key}) : isDesktop = true;
  const NFTItemInfo.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      // 資料區 上半部
      CommodityBodyTop(),
      NFTSectionItemTitle(
        iconPath: 'assets/desktop-icon-commodity-nft-describe.svg',
        title: '',
      )
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

/// NFT Section title 元件
class NFTSectionItemTitle extends StatelessWidget {
  // icon 路徑
  final String iconPath;
  // title
  final String title;

  const NFTSectionItemTitle(
      {super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    final arrowKey = GlobalKey<StateClickArrow>();
    return GestureDetector(
      onTap: () {
        arrowKey.currentState?.rotate();
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
            Text(title),
            const Expanded(child: SizedBox()),
            // 上/下箭頭
            BtnArrowUpDown(key: arrowKey, size: 20),
          ],
        ),
      ),
    );
  }
}

class NFTSectionDescription extends StatelessWidget {
  const NFTSectionDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return const Text('data');
    });
  }
}
