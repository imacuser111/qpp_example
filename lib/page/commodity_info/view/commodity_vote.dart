import 'package:flutter/widgets.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';

class VoteItemInfo extends StatelessWidget {
  const VoteItemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      // 資料區 上半部
      CommodityBodyTop(),
      // 資料區下半部
      // TODO: 問券內容 replace here
      SizedBox.shrink(),
    ]);
  }
}
