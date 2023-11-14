import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/model/item_img_data.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 物品圖片
class ItemImgPhoto extends ConsumerWidget {
  // 物品資訊 Model Provider
  final ChangeNotifierProvider<CommodityInfoModel> provider;
  // 是否為 mobile 版面
  final bool isMobile;

  /// 一般版面 constructor
  const ItemImgPhoto({super.key, required this.provider}) : isMobile = false;

  /// Mobile 版面 constructor
  const ItemImgPhoto.mobile({super.key, required this.provider})
      : isMobile = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse<ItemImgData> itemPhotoState =
        ref.watch(provider).itemPhotoState;

    if (itemPhotoState.status == Status.completed) {
      ItemImgData imgData = itemPhotoState.data!;
      // 確認是否為 NFT 圖片
      if (imgData.isNFT) {
        return _imgNFT(imgData.path, imgData.bgColor);
      }
      return _img(itemPhotoState.data!.path);
    }
    return const SizedBox(
      height: 0,
    );
  }

  /// desktop 一般物品, size 100 or 88, 圓形
  Container _img(String path) {
    return Container(
      width: isMobile ? 88 : 110,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: _circleDecor(),
      // foregroundDecoration 畫框線用
      foregroundDecoration: _circleDecorBorder(),
      child: Image.network(
        path,
        // 圖片讀取錯誤處理
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            'assets/desktop-pic-commodity-avatar-default.svg',
          );
        },
        filterQuality: FilterQuality.high,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  /// desktop NFT 物品, size 180 or 144, radius 8
  Container _imgNFT(String path, Color background) {
    return Container(
      width: isMobile ? 144 : 180,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: _rectDecor(background: background),
      // foregroundDecoration 畫框線用
      foregroundDecoration: _rectDecorBorder(),
      child: Image.network(
        path,
        // 圖片讀取錯誤處理
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            'assets/desktop-pic-commodity-avatar-default.svg',
          );
        },
        filterQuality: FilterQuality.high,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

/// 切圓形
BoxDecoration _circleDecor() {
  return const BoxDecoration(shape: BoxShape.circle);
}

/// 切圓框線
BoxDecoration _circleDecorBorder() {
  return BoxDecoration(
    shape: BoxShape.circle,
    // TODO: 確認框線顏色
    border: Border.all(color: QppColor.oxfordBlue, width: 1.0),
  );
}

/// 切圓角
BoxDecoration _rectDecor({required Color background}) {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));
}

/// 切圓角框線
BoxDecoration _rectDecorBorder() {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      // TODO: 確認框線顏色
      border: Border.all(color: QppColor.oxfordBlue, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));
}
