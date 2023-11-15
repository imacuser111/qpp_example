import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_ui/qpp_qrcode/universal_link_qrcode.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_empty.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_normal.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 完整路徑, 產 QR Code 用
String qrCodeUrl = '';

/// 物品 ID
String commodityID = "";

/// 物品資訊 view model
late ChangeNotifierProvider<CommodityInfoModel> itemSelectInfoProvider;

class CommodityInfoPage extends StatefulWidget {
  final GoRouterState routerState;
  const CommodityInfoPage({super.key, required this.routerState});

  @override
  State<StatefulWidget> createState() {
    return _CommodityInfoPageState();
  }
}

/// 物品資訊頁
class _CommodityInfoPageState extends State<CommodityInfoPage> {
  Size? size;
  // 是否為桌面版面
  bool isDesktopStyle = true;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // 是否為桌面版面
    isDesktopStyle = size?.width.determineScreenStyle().isDesktopStyle ?? false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    qrCodeUrl = ServerConst.routerHost + widget.routerState.uri.toString();
    commodityID =
        UniversalLinkParamData.fromJson(widget.routerState.uri.queryParameters)
                .commodityID ??
            "";
    // model 初始化
    itemSelectInfoProvider = ChangeNotifierProvider<CommodityInfoModel>((ref) {
      // 開始取資料
      Future.microtask(() => ref.notifier.loadData(commodityID));
      return CommodityInfoModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // 上方資料區
      isDesktopStyle ? const InfoCard.desktop() : const InfoCard.mobile(),
      // 下方 QR Code / 按鈕
      context.isDesktopPlatform
          ? UniversalLinkQRCode(str: qrCodeUrl)
          : const OpenQppButton(),
      // 底部間距
      const SizedBox(
        height: 40,
      )
    ]);
  }
}

///  上方資料卡片容器
class InfoCard extends StatelessWidget {
  // 版面判斷
  final bool isDesktop;

  /// 桌面裝置版面
  const InfoCard.desktop({super.key}) : isDesktop = true;

  /// 移動裝置版面
  const InfoCard.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          // 切子元件超出範圍
          clipBehavior: Clip.hardEdge,
          semanticContainer: false,
          // 容器與四周間距
          margin: isDesktop
              ? const EdgeInsets.fromLTRB(60, 100, 60, 40)
              : const EdgeInsets.fromLTRB(24, 24, 24, 24),
          color: QppColor.prussianBlue,
          shape: RoundedRectangleBorder(
            // 圓角參數
            borderRadius: BorderRadius.circular(8),
          ),
          // Card 陰影
          elevation: 0,
          child: Consumer(
            builder: (context, ref, child) {
              // 取資料狀態通知
              ApiResponse<QppItem> itemInfoState =
                  ref.watch(itemSelectInfoProvider).itemSelectInfoState;
              if (itemInfoState.status == Status.completed) {
                // 有取得物品資料
                return const NormalItemInfo();
              } else {
                // 沒有取得物品資料
                return isDesktop
                    ? const EmptyInfo.desktop()
                    : const EmptyInfo.mobile();
              }
            },
          ),
        ),
      ],
    );
  }
}
