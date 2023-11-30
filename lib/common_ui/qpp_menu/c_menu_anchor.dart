import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import '../qpp_app_bar/view/qpp_app_bar_view.dart';

/// 客製化選單資料
abstract class CMeunAnchorData {
  String get title;
  String? get image;
}

/// 客製化選單
///
/// Note: 樣式請參考語系選單
class CMenuAnchor extends StatelessWidget {
  const CMenuAnchor(
      {super.key,
      required this.list,
      this.builder,
      required this.isOpenControllerProvider,
      required this.onTap});

  final List<CMeunAnchorData> list;
  // 控制器狀態Provider
  final StateProvider<bool> isOpenControllerProvider;
  final Widget Function(BuildContext, MenuController, Widget?)? builder;
  final void Function(BuildContext context, CMeunAnchorData e) onTap;

  @override
  Widget build(BuildContext context) {
    // Item
    List<Consumer> items = list
        .map(
          (e) => Consumer(builder: (context, ref, child) {
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            return MouseRegionCustomWidget(
              onEnter: (event) => context.isDesktopPlatform
                  ? isOpenNotifier.state = true
                  : null,
              onExit: (event) => context.isDesktopPlatform
                  ? isOpenNotifier.state = false
                  : null,
              builder: (event) {
                final Color color = event is PointerEnterEvent
                    ? QppColors.canaryYellow
                    : QppColors.white;
                final image = e.image;
                final isShowImage = image != null;

                return MenuItemButton(
                  onPressed: () {
                    onTap(context, e);
                    isOpenNotifier.state = false;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: isShowImage ? 0 : 12,
                        right: 12),
                    child: Row(
                      children: [
                        isShowImage
                            ? SvgPicture.asset(
                                image,
                                colorFilter:
                                    ColorFilter.mode(color, BlendMode.srcIn),
                              )
                            : const SizedBox.shrink(),
                        isShowImage
                            ? const SizedBox(width: 6)
                            : const SizedBox.shrink(),
                        Text(context.tr(e.title),
                            style: event is PointerEnterEvent
                                ? QppTextStyles.mobile_14pt_body_canary_yellow_L
                                : QppTextStyles.mobile_14pt_body_white_L),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        )
        .toList();

    return MenuAnchor(
      builder: builder,
      menuChildren: items,
      style: MenuStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color(0xff000b2b).withOpacity(0.6)),
      ),
    );
  }
}
