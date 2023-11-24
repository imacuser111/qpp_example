import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_text/read_more_text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/item_multi_language_data.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'dart:ui' as ui;

/// 一般物品資訊
class NormalItemInfo extends StatelessWidget {
  const NormalItemInfo({super.key});
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
              ItemInfoRow(),
              // 創建者欄位
              CreatorInfoRow(),
              // 連結欄位
              ItemIntroLinkRow(),
              // 說明欄位
              ItemDescriptionRow(),
            ],
          )),
    ]);
  }
}

/// 資訊顯示抽象類
abstract class InfoRow extends ConsumerWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse response = getResponse(ref);
    dynamic data = response.data;

    return response.isCompleted
        ? Padding(
            padding: const EdgeInsets.fromLTRB(60, 14, 60, 14),
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
  const ItemInfoRow({super.key});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).itemSelectInfoState;
  }

  @override
  Widget getContent(data) {
    if (data is QppItem) {
      return Builder(builder: (context) {
        return Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 120),
              width: double.infinity,
              child: Text(
                context.tr(QppLocales.commodityInfoCategory),
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
              ),
            ),
            SvgPicture.asset(
              'assets/${data.categoryIconPath}',
              width: 20,
            ),
            // 間隔
            const SizedBox(
              width: 8,
            ),
            // 類別名稱
            Text(
              data.categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: QppColor.platinum),
            ),
            // 間隔
            const SizedBox(
              width: 8,
            ),
            // 物品 ID
            Text(
              data.id.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18, color: QppColor.mediumAquamarine),
            ),
          ],
        );
      });
    }
    return const SizedBox();
  }
}

/// 創建者資訊
class CreatorInfoRow extends InfoRow {
  const CreatorInfoRow({super.key});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).userInfoState;
  }

  @override
  Widget getContent(data) {
    if (data is QppUser) {
      return Builder(builder: (context) {
        return Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                context.tr(QppLocales.commodityInfoCreator),
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
              ),
            ),
            // 若為官方帳號, 顯示 icon
            data.isOfficial
                ? Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(
                      'assets/${data.officialIconPath}',
                      width: 20,
                    ),
                  )
                : const SizedBox(),
            // id + name
            Expanded(
              child: Text(
                "${data.displayID}  ${data.displayName}",
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 18, color: QppColor.indianYellow),
              ),
            ),
            // 物件左右翻轉, 或用 RotatedBox
            Directionality(
                textDirection: ui.TextDirection.rtl,
                child: SvgPicture.asset(
                  'assets/mobile-icon-actionbar-back-normal.svg',
                  matchTextDirection: true,
                )),
          ],
        );
      });
    }
    return const SizedBox();
  }
}

/// 物品連結資訊(多語系)
class ItemIntroLinkRow extends InfoRow {
  const ItemIntroLinkRow({super.key});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).itemLinkInfoState;
  }

  @override
  Widget getContent(data) {
    if (data is ItemMultiLanguageData) {
      // 檢查是否有資料
      if (data.hasContent) {
        // 有資料才顯示
        return Builder(builder: (context) {
          return Row(
            // 子元件對齊頂端
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  context.tr(QppLocales.commodityInfoTitle),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 18, color: QppColor.babyBlueEyes),
                ),
              ),
              // intro link
              Expanded(
                // Expanded 包 text, 實現自動換行
                child: InfoLinkReadMoreText(
                    data: data.getContentWithContext(context)),
              ),
            ],
          );
        });
      }
    }
    return const SizedBox();
  }
}

/// 物品說明資訊(多語系)
class ItemDescriptionRow extends InfoRow {
  const ItemDescriptionRow({super.key});

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).itemDescriptionInfoState;
  }

  @override
  Widget getContent(data) {
    if (data is ItemMultiLanguageData) {
      // 檢查是否有資料
      if (data.hasContent) {
        // 有資料才顯示
        return Builder(builder: (context) {
          return Row(
            // 子元件對齊頂端
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  context.tr(QppLocales.commodityInfoInfo),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 18, color: QppColor.babyBlueEyes),
                ),
              ),
              // intro link
              Expanded(
                // Expanded 包 text, 實現自動換行
                child: InfoLinkReadMoreText(
                    data: data.getContentWithContext(context)),
              ),
            ],
          );
        });
      }
    }
    return const SizedBox();
  }
}

/// 連結及說明用, 顯示更多及開啟連結用 Text Widget
class InfoLinkReadMoreText extends StatelessWidget {
  final String data;
  const InfoLinkReadMoreText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      data,
      textAlign: TextAlign.start,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimExpandedText: '',
      trimCollapsedText: context.tr('commodity_info_more'),
      moreStyle: const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
      style: const TextStyle(fontSize: 18, color: QppColor.platinum),
      linkTextStyle: const TextStyle(fontSize: 18, color: QppColor.mayaBlue),
      onLinkPressed: (String url) {
        // 打開連結
        url.launchURL();
      },
    );
  }
}
