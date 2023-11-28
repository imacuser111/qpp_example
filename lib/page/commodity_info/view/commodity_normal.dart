import 'package:flutter/material.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';

/// 一般物品資訊
class NormalItemInfo extends StatelessWidget {
  final bool isDesktop;
  const NormalItemInfo.desktop({super.key}) : isDesktop = true;
  const NormalItemInfo.mobile({super.key}) : isDesktop = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      const CommodityBodyTop(),
      // 資料區下半部
      Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 20),
          child: const Column(
            children: [
              // 類別欄位
              InfoRowInfo(),
              // 創建者欄位
              InfoRowCreator(),
              // 連結欄位
              InfoRowIntroLink(),
              // 說明欄位
              InfoRowDescription(),
            ],
          )),
    ]);
  }
}
