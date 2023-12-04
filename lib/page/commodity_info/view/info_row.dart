import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_text/info_row_link_read_more_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/item_multi_language_data.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'dart:ui' as ui;

import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 資訊顯示抽象類
/// 物品資訊 Row
abstract class InfoRow extends ConsumerWidget {
  final bool isDesktop;
  const InfoRow.desktop({super.key}) : isDesktop = true;
  const InfoRow.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse response = getResponse(ref);
    dynamic data = response.data;

    return response.isCompleted
        ? Padding(
            padding: _rowPadding(),
            child: getContent(data),
          )
        : const SizedBox.shrink();
  }

  ApiResponse getResponse(WidgetRef ref);

  Widget getContent(dynamic data);

  _rowPadding() {
    return isDesktop
        ? const EdgeInsets.fromLTRB(60, 14, 60, 14)
        : const EdgeInsets.fromLTRB(14, 10, 14, 10);
  }

  double get _titleWidth {
    return isDesktop ? 120 : 90;
  }
}

/// 物品資訊
class InfoRowInfo extends InfoRow {
  const InfoRowInfo.desktop({super.key}) : super.desktop();
  const InfoRowInfo.mobile({super.key}) : super.mobile();

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
              constraints: BoxConstraints(maxWidth: _titleWidth),
              width: double.infinity,
              child: Text(
                context.tr(QppLocales.commodityInfoCategory),
                textAlign: TextAlign.start,
                style: QppTextStyles.web_16pt_body_category_text_L,
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
              style: QppTextStyles.web_16pt_body_platinum_L,
            ),
            // 間隔
            const SizedBox(
              width: 8,
            ),
            // 物品 ID
            Text(
              data.id.toString(),
              textAlign: TextAlign.center,
              style: QppTextStyles.web_16pt_body_ID_text_L,
            ),
          ],
        );
      });
    }
    return const SizedBox.shrink();
  }
}

/// 創建者資訊
class InfoRowCreator extends InfoRow {
  // final bool isCreator;

  /// 若為一般物品, 顯示創建者
  const InfoRowCreator.desktop({super.key}) : super.desktop();
  const InfoRowCreator.mobile({super.key}) : super.mobile();

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).userInfoState;
  }

  @override
  Widget getContent(data) {
    if (data is QppUser) {
      return Builder(builder: (context) {
        // 關掉 SelectionArea 游標功能
        return SelectionContainer.disabled(
          child: MouseRegion(
            // 滑鼠移進來時會改變游標圖案
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // TODO: host, isTesting, language....
                '${ServerConst.routerHost}/app/information?phoneNumber=${data.displayID}&testing=true'
                    .launchURL(isNewTab: false);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: _titleWidth,
                    child: Text(
                      context.tr(QppLocales.commodityInfoCreator),
                      textAlign: TextAlign.start,
                      style: QppTextStyles.web_16pt_body_category_text_L,
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
                      : const SizedBox.shrink(),
                  // id + name
                  Expanded(
                    child: Text(
                      "${data.displayID}  ${data.displayName}",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: QppTextStyles.web_16pt_body_Indian_yellow_L,
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
              ),
            ),
          ),
        );
      });
    }
    return const SizedBox.shrink();
  }
}

/// 物品連結資訊(多語系)
class InfoRowIntroLink extends InfoRow {
  const InfoRowIntroLink.desktop({super.key}) : super.desktop();
  const InfoRowIntroLink.mobile({super.key}) : super.mobile();

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
                width: _titleWidth,
                child: Text(
                  context.tr(QppLocales.commodityInfoTitle),
                  textAlign: TextAlign.start,
                  style: QppTextStyles.web_16pt_body_category_text_L,
                ),
              ),
              // intro link
              Expanded(
                // Expanded 包 text, 實現自動換行
                child: InfoRowLinkReadMoreText(
                    data: data.getContentWithContext(context)),
              ),
            ],
          );
        });
      }
    }
    return const SizedBox.shrink();
  }
}

/// 物品說明資訊(多語系)
class InfoRowDescription extends InfoRow {
  const InfoRowDescription.desktop({super.key}) : super.desktop();
  const InfoRowDescription.mobile({super.key}) : super.mobile();

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
                width: _titleWidth,
                child: Text(
                  context.tr(QppLocales.commodityInfoInfo),
                  textAlign: TextAlign.start,
                  style: QppTextStyles.web_16pt_body_category_text_L,
                ),
              ),
              // intro link
              Expanded(
                // Expanded 包 text, 實現自動換行
                child: InfoRowLinkReadMoreText(
                    data: data.getContentWithContext(context)),
              ),
            ],
          );
        });
      }
    }
    return const SizedBox.shrink();
  }
}
