import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/item_image.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CommodityInfoPage extends StatefulWidget {
  final GoRouterState routerState;
  const CommodityInfoPage({super.key, required this.routerState});

  @override
  State<StatefulWidget> createState() {
    return _CommodityInfoPageState();
  }
}

class _CommodityInfoPageState extends State<CommodityInfoPage> {
  // 完整路徑, 產 QR Code 用
  String qrCodeUrl = '';
  // 物品 ID
  String commodityID = "";
  late ChangeNotifierProvider<CommodityInfoModel> itemSelectInfoProvider;

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
      print('debug load data');
      Future.microtask(() => ref.notifier.loadData(commodityID));
      return CommodityInfoModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('debug build CommodityInfoPage');
    return ListView(children: [
      // 上方資料卡片容器
      Card(
        // 切子元件超出範圍
        clipBehavior: Clip.hardEdge,
        semanticContainer: false,
        // margin: EdgeInsets.fromLTRB(120.w, 60.h, 120.w, 40),
        color: QppColor.prussianBlue,
        shape: RoundedRectangleBorder(
          // 圓角參數
          borderRadius: BorderRadius.circular(8),
        ),
        // Card 陰影
        elevation: 0,
        child: Column(children: [
          // 資料區 上半部
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(top: 80, bottom: 30),
            width: double.infinity,
            // 上半部 bg
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'desktop-pic-commodity-largepic-sample-general.webp'),
                    fit: BoxFit.cover)),
            child: Column(children: [
              // 物品圖片
              ItemImgPhoto(provider: itemSelectInfoProvider),
              const SizedBox(
                height: 45,
              ),
              // 物品名稱
              Consumer(builder: (context, ref, _) {
                ApiResponse<QppItem> itemInfoState =
                    ref.watch(itemSelectInfoProvider).itemSelectInfoState;
                return itemInfoState.status == Status.completed
                    ? Text(
                        itemInfoState.data!.name,
                        style: const TextStyle(
                            fontSize: 30, color: QppColor.white),
                      )
                    : const SizedBox();
              }),
            ]),
          ),
          // 資料區下半部
          Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  // 類別欄位
                  ItemInfoRow(
                    provider: itemSelectInfoProvider,
                  ),
                  // 創建者欄位
                  CreatorInfoRow(provider: itemSelectInfoProvider),
                ],
              )),
        ]),
      ),
      // QR Code

      Center(
        child: Card(
          margin: const EdgeInsets.only(bottom: 15, top: 50),
          // 切子元件超出範圍
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            // 圓角參數
            borderRadius: BorderRadius.circular(8),
          ),
          child: QrImageView(
            backgroundColor: QppColor.white,
            data: qrCodeUrl,
            size: 150,
          ),
        ),
      ),
      // 下方
      const Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Text(
          '掃描條碼從QPP中開啟',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: QppColor.indianYellow,
              fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }
}

// TODO: TEST custom row layout

/// 資訊顯示抽象類
abstract class InfoRow extends ConsumerWidget {
  final ChangeNotifierProvider<CommodityInfoModel> provider;
  const InfoRow({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse response = getResponse(ref);
    dynamic data = response.data;
    return response.status == Status.completed
        ? Padding(
            padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
            child: getContent(data),
          )
        : const SizedBox(
            height: 0,
          );
  }

  ApiResponse getResponse(WidgetRef ref);

  Widget getContent(dynamic data);
}

/// 物品資訊
class ItemInfoRow extends InfoRow {
  const ItemInfoRow({super.key, required super.provider});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(provider).itemSelectInfoState;
  }

  @override
  Widget getContent(dynamic data) {
    // 使用多語系
    return _cellCategory(title: QppLocales.commodityInfoCategory, item: data);
  }
}

/// 創建者資訊
class CreatorInfoRow extends InfoRow {
  const CreatorInfoRow({super.key, required super.provider});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(provider).userInfoState;
  }

  @override
  Widget getContent(data) {
    // 使用多語系
    return _cellCreator(title: QppLocales.commodityInfoCreator, creator: data);
  }
}

/// 類別
Widget _cellCategory({required String title, required QppItem item}) {
  return Row(
    children: [
      SizedBox(
        width: 180,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
        ),
      ),
      // 類別 icon
      SvgPicture.asset(
        item.categoryIconPath,
        width: 20,
      ),
      // 間隔
      const SizedBox(
        width: 8,
      ),
      // 類別名稱
      Text(
        item.categoryName,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, color: QppColor.platinum),
      ),
      // 間隔
      const SizedBox(
        width: 8,
      ),
      // 物品 ID
      Text(
        item.id.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, color: QppColor.mediumAquamarine),
      ),
    ],
  );
}

/// 創建者
Widget _cellCreator({required String title, required QppUser creator}) {
  return Row(
    children: [
      SizedBox(
        width: 180,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
        ),
      ),
      // 若為官方帳號, 顯示 icon
      creator.isOfficial
          ? Container(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                creator.officialIconPath,
                width: 20,
              ),
            )
          : const SizedBox(),
      // id
      Text(
        creator.displayID,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, color: QppColor.indianYellow),
      ),
      // 間隔
      const SizedBox(
        width: 8,
      ),
      // name
      Text(
        creator.displayName,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, color: QppColor.indianYellow),
      ),
      const Expanded(child: Text('')),
      // 物件左右翻轉, 或用 RotatedBox
      Directionality(
          textDirection: TextDirection.rtl,
          child: SvgPicture.asset(
            'mobile-icon-actionbar-back-normal.svg',
            matchTextDirection: true,
          )),
    ],
  );
}
