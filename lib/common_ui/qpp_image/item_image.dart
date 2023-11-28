import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/model/item_img_data.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 物品圖片
class ItemImgPhoto extends ConsumerWidget {
  // 是否為 mobile 版面
  final bool isMobile;

  /// 一般版面 constructor
  const ItemImgPhoto({super.key}) : isMobile = false;

  /// Mobile 版面 constructor
  const ItemImgPhoto.mobile({super.key}) : isMobile = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 監聽 photo url state
    ApiResponse<ItemImgData> itemPhotoState =
        ref.watch(itemSelectInfoProvider).itemPhotoState;

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
      margin: const EdgeInsets.only(top: 83),
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
      margin: const EdgeInsets.only(top: 48),
      width: isMobile ? 144 : 180,
      height: isMobile ? 144 : 180,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: _rectDecor(background: background),
      // foregroundDecoration 畫框線用
      foregroundDecoration: _rectDecorBorder(),
      child: Stack(children: [
        Image.network(
          path,
          // 圖片讀取錯誤處理
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitWidth,
        ),
        // 圖片放大按鈕
        Positioned(
            bottom: 5,
            right: 5,
            child: ExpandPhotoBtnWidget(
              imgPath: path,
            )),
      ]),
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
    border: Border.all(color: QppColors.oxfordBlue, width: 1.0),
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
      border: Border.all(color: QppColors.oxfordBlue, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));
}

/// 點擊展開圖片元件
class ExpandPhotoBtnWidget extends StatelessWidget {
  final String imgPath;
  const ExpandPhotoBtnWidget({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: SvgPicture.asset(
            'assets/mobile-icon-image-magnifier.svg',
            width: 30,
            height: 30,
          ),
          onTap: () {
            // 顯示自訂 dialog
            showGeneralDialog(
              context: context,
              pageBuilder: (_, animation, secondaryAnimation) {
                // dialog 自訂顯示元件
                return Stack(children: [
                  ClipRect(
                    // 毛玻璃效果
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Center(
                    // 顯示圖片
                    child: Image.network(
                      imgPath,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ]);
              },
              barrierDismissible: true,
              // 語義化標籤(HTML)
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              // 動畫時間
              transitionDuration: const Duration(milliseconds: 150),
              // 自訂動畫
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                // 使用縮放動畫
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                );
              },
            );
          },
        ));
  }
}
