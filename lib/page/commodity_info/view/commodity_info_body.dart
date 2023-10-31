import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CommodityInfoPage extends StatelessWidget {
  final GoRouterState routerState;

  const CommodityInfoPage({super.key, required this.routerState});

  @override
  Widget build(BuildContext context) {
    // 物品 ID
    String commodityID =
        UniversalLinkParamData.fromJson(routerState.uri.queryParameters)
                .commodityID ??
            "";
    // 完整路徑, 產 QR Code 用
    String qrCodeUrl = ServerConst.routerHost + routerState.uri.toString();

    late final itemSelectInfoProvider =
        ChangeNotifierProvider<CommodityInfoModel>((ref) {
      Future.microtask(() => ref.notifier.loadData(commodityID));
      return CommodityInfoModel();
    });

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
              // 物品 icon
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

          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ItemInfoRow(
                provider: itemSelectInfoProvider,
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

/// 物品圖片
class ItemImgPhoto extends ConsumerWidget {
  final ChangeNotifierProvider<CommodityInfoModel> provider;

  const ItemImgPhoto({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse<String> itemPhotoState = ref.watch(provider).itemPhotoState;

    return itemPhotoState.status == Status.completed
        ? ClipOval(
            child: Image.network(
              itemPhotoState.data!,
              errorBuilder: (context, error, stackTrace) {
                return SvgPicture.asset(
                  'desktop-pic-commodity-avatar-default.svg',
                );
              },
              width: 100,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitWidth,
            ),
          )
        : const SizedBox(
            height: 0,
          );
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
        ? getContent(data)
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
    return _rowCell(title: '類別', data: data);
  }
}

/// 內容 cell
Widget _rowCell({required String title, required dynamic data}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Row(
      children: [
        // 左邊標題
        SizedBox(
          width: 180,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
          ),
        ),
        // 取得右邊內容
        getCellContentWidget(data),
      ],
    ),
  );
}

/// 取得右邊內容
Widget getCellContentWidget(dynamic data) {
  if (data is QppItem) {
    return _cellCategory(item: data);
  }
  return const SizedBox();
}

/// 類別
Expanded _cellCategory({required QppItem item}) {
  return Expanded(
      child: Row(
    children: [
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
  ));
}

/// 類別 Cell
List<Widget> _categoryCell(ItemData data) {
  return [
    // title
    const TableCell(
      verticalAlignment: TableCellVerticalAlignment.baseline,
      child: Padding(
        padding: const EdgeInsets.only(left: 60, top: 15, bottom: 15),
        child: Text(
          '類別',
          style: const TextStyle(color: QppColor.babyBlueEyes, fontSize: 20),
        ),
      ),
    ),
    // data
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.baseline,
      child: Row(children: [
        // TODO: 類別 Icon
        // 類別 icon
        SvgPicture.asset(
          'desktop-icon-display-treasure.svg',
          width: 20,
        ),

        const SizedBox(
          width: 10,
        ),
        // TODO: 類別名稱
        // 類別
        const Text(
          '類別名稱',
          style: const TextStyle(color: QppColor.white, fontSize: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        // id
        Text(
          data.id.toString(),
          style:
              const TextStyle(color: QppColor.mediumAquamarine, fontSize: 20),
        ),
      ]),
    ),
  ];
}
