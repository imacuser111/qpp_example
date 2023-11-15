import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/item_image.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_ui/qpp_qrcode.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/item_multi_language_data.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_model.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/screen.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';

import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/read_more_text.dart';

/// 完整路徑, 產 QR Code 用
String qrCodeUrl = '';

/// 物品 ID
String commodityID = "";

/// view model
late ChangeNotifierProvider<CommodityInfoModel> itemSelectInfoProvider;

class CommodityInfoPage extends StatefulWidget {
  final GoRouterState routerState;
  const CommodityInfoPage({super.key, required this.routerState});

  @override
  State<StatefulWidget> createState() {
    return _CommodityInfoPageState();
  }
}

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
    ]);
  }
}

///  桌面版本上方資料卡片容器
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
          // TODO: 取資料中....
          child: Consumer(
            builder: (context, ref, child) {
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

/// 一般物品資訊
class NormalItemInfo extends StatelessWidget {
  const NormalItemInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 80, bottom: 30),
        constraints: const BoxConstraints(maxWidth: 1280),
        width: double.infinity,
        // 上半部 bg
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/desktop-pic-commodity-largepic-sample-general.webp'),
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
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      itemInfoState.data!.name,
                      style:
                          const TextStyle(fontSize: 30, color: QppColor.white),
                    ),
                  )
                : const SizedBox();
          }),
        ]),
      ),
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
              //
              ItemIntroLinkRow(),
              //
              ItemDescriptionRow(),
            ],
          )),
    ]);
  }
}

/// 無此物品
class EmptyInfo extends StatelessWidget {
  final bool isDesktop;
  const EmptyInfo.desktop({super.key}) : isDesktop = true;
  const EmptyInfo.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? Container(
            constraints: const BoxConstraints(maxWidth: 1280, maxHeight: 324),
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emptyImg(),
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    context.tr(QppLocales.qppState9),
                    style: const TextStyle(
                        fontSize: 16, color: QppColor.babyBlueEyes),
                  ),
                )
              ],
            ),
          )
        : Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emptyImg(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    context.tr(QppLocales.qppState9),
                    style: const TextStyle(
                        fontSize: 16, color: QppColor.babyBlueEyes),
                  ),
                )
              ],
            ),
          );
  }

  _emptyImg() {
    return SvgPicture.asset(
      'assets/pic-empty-default.svg',
      width: isDesktop ? 202 : 165,
      height: isDesktop ? 146 : 119,
    );
  }
}

/// 資訊顯示抽象類
abstract class InfoRow extends ConsumerWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiResponse response = getResponse(ref);
    dynamic data = response.data;

    return response.status == Status.completed
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
        _launchURL(url);
      },
    );
  }

  /// 打開連結
  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    // 使用 url launcher 開啟連結
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
