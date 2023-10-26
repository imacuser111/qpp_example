import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';

class CommodityInfoPage extends StatelessWidget {
  final String commodityID;

  const CommodityInfoPage({super.key, required this.commodityID});

  @override
  Widget build(BuildContext context) {
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
              ItemImgPhoto(provider: itemSelectInfoProvider)
              // ClipOval(
              //   child: Image.network(
              //     'https://storage.googleapis.com/qpp_blockchain/Item/9E56D46E4848CD1BBF82A8ADA053FF68806193A204F47058B2FB87AB0C32288C_109555_Image1.png?v=1683259489078672',
              //     errorBuilder: (context, error, stackTrace) {
              //       return SvgPicture.asset(
              //         'desktop-pic-commodity-avatar-default.svg',
              //       );
              //     },
              //     width: 100,
              //     filterQuality: FilterQuality.high,
              //     fit: BoxFit.fitWidth,
              //   ),
              // )
              ,
              const SizedBox(
                height: 45,
              ),
              // 物品名稱
              Consumer(builder: (context, ref, _) {
                ApiResponse<ItemData> itemInfoState =
                    ref.watch(itemSelectInfoProvider).itemSelectInfoState;
                return Text(
                  getNameText(itemInfoState),
                  style: const TextStyle(fontSize: 30, color: QppColor.white),
                );
              }),
            ]),
          ),
          Consumer(builder: (context, ref, _) {
            ApiResponse<ItemData> itemInfoState =
                ref.watch(itemSelectInfoProvider).itemSelectInfoState;
            if (itemInfoState.status == Status.completed) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(180.0),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    _itemCategoryTableRow(
                        property: '類別',
                        value: itemInfoState.data!.id.toString()),
                    _itemCreatorTableRow(property: '創建者', value: '456'),
                    _itemDescriptionTableRow(
                        property: '說明',
                        value:
                            'https://storage.googleapis.com/qpp_blockchain/Item/9E56D46E4848CD1BBF82A8ADA053FF68806193A204F47058B2FB87AB0C32288C_109555_Image1.png?v=1683259489078672'),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          })
        ]),
      ),
      // QR Code
      Center(
        child: Card(
          margin: const EdgeInsets.only(bottom: 15),
          // 切子元件超出範圍
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            // 圓角參數
            borderRadius: BorderRadius.circular(8),
          ),
          // child: QrImageView(
          //   backgroundColor: QppColor.white,
          //   data:
          //       'https://qpptec.com/app/commodity_info?commodityID=109555&sharer=SUV5G42V&lang=zh_TW&openExternalBrowser=1&action=stay',
          //   size: 150,
          // ),
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

/// 取得物品名稱
String getNameText(ApiResponse<ItemData> state) {
  switch (state.status) {
    case Status.completed:
      return state.data!.name;
    default:
      // 非完成都回傳空字串
      return "";
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

// 類別 item
TableRow _itemCategoryTableRow(
    {required String property, required String value}) {
  return TableRow(
    children: [
      // title
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Padding(
          padding: const EdgeInsets.only(left: 60, top: 15, bottom: 15),
          child: Text(
            property,
            style: const TextStyle(color: QppColor.babyBlueEyes, fontSize: 20),
          ),
        ),
      ),
      // data
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Row(children: [
          // 類別 icon
          SvgPicture.asset(
            'desktop-icon-display-treasure.svg',
            width: 20,
          ),

          const SizedBox(
            width: 10,
          ),
          // 類別
          Text(
            value,
            style: const TextStyle(color: QppColor.white, fontSize: 20),
          ),
          const SizedBox(
            width: 10,
          ),
          // id
          Text(
            value,
            style:
                const TextStyle(color: QppColor.mediumAquamarine, fontSize: 20),
          ),
        ]),
      ),
    ],
  );
}

// 創建者 item
TableRow _itemCreatorTableRow(
    {required String property, required String value}) {
  return TableRow(
    children: [
      // title
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Padding(
          padding: const EdgeInsets.only(left: 60, top: 15, bottom: 15),
          child: Text(
            property,
            style: const TextStyle(color: QppColor.babyBlueEyes, fontSize: 20),
          ),
        ),
      ),
      // data
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: GestureDetector(
          onTap: () {
            print('Click Item Creator');
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Row(children: [
              // 官方 icon
              SvgPicture.asset(
                'mobile-icon-newsfeed-official-small.svg',
              ),
              const SizedBox(
                width: 10,
              ),
              // 創建者 id
              Text(
                value,
                style:
                    const TextStyle(color: QppColor.indianYellow, fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              // 創建者 name
              Text(
                value,
                style:
                    const TextStyle(color: QppColor.indianYellow, fontSize: 20),
              ),
              const Expanded(
                  child: Text(
                '',
              )),
              // 物件左右翻轉, 或用 RotatedBox
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: SvgPicture.asset(
                    'mobile-icon-actionbar-back-normal.svg',
                    matchTextDirection: true,
                  )),
            ]),
          ),
        ),
      ),
    ],
  );
}

// 說明 item
TableRow _itemDescriptionTableRow(
    {required String property, required String value}) {
  return TableRow(
    // title
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Padding(
          padding: const EdgeInsets.only(left: 60, top: 15, bottom: 15),
          child: Text(
            property,
            style: const TextStyle(color: QppColor.babyBlueEyes, fontSize: 20),
          ),
        ),
      ),
      // data
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        // 說明
        child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text(
            value,
            textDirection: TextDirection.ltr,
            softWrap: true,
            style: const TextStyle(color: QppColor.white, fontSize: 20),
          ),
        ),
      ),
    ],
  );
}
