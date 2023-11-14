import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'qpp_app_bar/view/qpp_app_bar_view.dart';

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
  final void Function(BuildContext context, WidgetRef ref, CMeunAnchorData e) onTap;

  @override
  Widget build(BuildContext context) {
    // Item
    List<Consumer> items = list
        .map(
          (e) => Consumer(builder: (context, ref, child) {
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            return MouseRegionCustomWidget(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              builder: (event) {
                final Color color =
                    event is PointerEnterEvent ? Colors.amber : Colors.white;
                final image = e.image;
                final isShowImage = image != null;

                return MenuItemButton(
                  onPressed: () {
                    onTap(context, ref, e);
                    isOpenNotifier.state = false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        isShowImage
                            ? SvgPicture.asset(image)
                            : const SizedBox.shrink(),
                        isShowImage
                            ? const SizedBox(width: 6)
                            : const SizedBox.shrink(),
                        Text(e.title, style: TextStyle(color: color)),
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
