import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/model/enum/language.dart';
import 'package:qpp_example/utils/screen.dart';

AppBar qppAppBar({required double height}) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight: height,
    backgroundColor: QppColor.onyx60,
    title: const QppAppBarTitle(),
  );
}

class QppAppBarTitle extends ConsumerWidget {
  const QppAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(toString());

    final Size size = MediaQuery.of(context).size;
    final bool isDesktopStyle =
        size.width.determineScreenStyle().isDesktopStyle;

    final notifier = ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

    final bool isShowFullScreenMenu =
        ref.watch(isOpenAppBarMenuBtnPageProvider);

    return Row(
      children: [
        // 最左邊間距
        Flexible(
          child: isDesktopStyle
              ? const SizedBox(width: double.maxFinite)
              : const SizedBox.shrink(),
        ),
        isShowFullScreenMenu ? const SizedBox.shrink() : const _Logo(),
        // QPP -> Button 間距
        const Spacer(flex: 2),
        // 選單按鈕
        isDesktopStyle
            ? const _MenuBtns()
            : const Spacer(flex: 100), // felx設定一個大的數字讓他填充到最大
        // 語系
        const Padding(
          padding: EdgeInsets.only(left: 74),
          child: LanguageDropdownMenu(),
        ),
        // 三條 or 最右邊間距
        isShowFullScreenMenu
            ? const SizedBox(width: 39)
            : isDesktopStyle
                ? const Flexible(child: SizedBox.shrink())
                : AnimationMenuBtn(isClose: false, notifier: notifier),
      ],
    );
  }
}

// QPP Logo
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final bool isDesktopStyle =
        MediaQuery.of(context).size.width.determineScreenStyle().isDesktopStyle;

    return IconButton(
      icon: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 148),
        child: Image.asset(
          'desktop-pic-qpp-logo-01.png',
          width: isDesktopStyle ? 148 : 100,
          scale: 46 / 148,
        ),
      ),
      onPressed: () => context.goNamed("home"),
    );
  }
}

/// 選單按鈕(Row)
/// - Note: 產品介紹...等
class _MenuBtns extends StatelessWidget {
  const _MenuBtns();

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    return Row(
      children: MainMenu.values
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(right: e == MainMenu.contact ? 0 : 30),
              child: MouseRegionCustomWidget(
                builder: (event) => MouseRegion(
                  cursor: SystemMouseCursors.click, // 改鼠標樣式
                  child: GestureDetector(
                    onTap: () {
                      BuildContext? currentContext = e.currentContext;

                      if (currentContext != null) {
                        Scrollable.ensureVisible(currentContext,
                            duration: const Duration(seconds: 1));
                      }
                    }.throttleWithTimeout(timeout: 2000),
                    child: Text(
                      e.value,
                      style: TextStyle(
                          color: event is PointerEnterEvent
                              ? Colors.amber
                              : Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

/// animationMenuBtn(三條or關閉)
class AnimationMenuBtn extends StatefulWidget {
  const AnimationMenuBtn(
      {super.key, required this.isClose, required this.notifier});

  final bool isClose;
  final IsOpenAppBarMenuBtnPageStateNotifier notifier;

  @override
  State<StatefulWidget> createState() => _AnimationMenuBtn();
}

class _AnimationMenuBtn extends State<AnimationMenuBtn>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  int _count = 0;
  final int _targetCount = 1;

  @override
  void initState() {
    super.initState();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _count++;
        if (_count < _targetCount) {
          _controller.reset();
          _controller.forward();
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // 要在super.dispose()之前處置Ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: -_controller.value * 2 * pi,
          child: IconButton(
            onPressed: () => widget.notifier.toggle(),
            icon: widget.isClose || _count < _targetCount
                ? const Icon(Icons.close, color: Colors.white)
                : const Icon(Icons.menu, color: Colors.white),
          ),
        );
      },
    );
  }
}

/// 語系下拉選單
class LanguageDropdownMenu extends StatelessWidget {
  const LanguageDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final StateProvider<bool> isOpenControllerProvider =
        StateProvider((ref) => false);

    // Item
    List<Consumer> items = Language.values
        .map(
          (e) => Consumer(builder: (context, ref, child) {
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            return MouseRegionCustomWidget(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              builder: (event) => MenuItemButton(
                onPressed: () {
                  context.setLocale(e.locale);
                  isOpenNotifier.state = false;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    e.displayTitle,
                    style: TextStyle(
                        color: event is PointerEnterEvent
                            ? Colors.amber
                            : Colors.white),
                  ),
                ),
              ),
            );
          }),
        )
        .toList();

    return MenuAnchor(
      builder: (context, controller, child) {
        return Consumer(builder: (context, ref, child) {
          final isOpen = ref.watch(isOpenControllerProvider);
          final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

          Future.microtask(
              () => isOpen ? controller.open() : controller.close());

          return MouseRegion(
            onEnter: (event) => isOpenNotifier.state = true,
            onExit: (event) => isOpenNotifier.state = false,
            child: IconButton(
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
              icon: const Row(
                children: [
                  Icon(Icons.language, color: Colors.white),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white)
                ],
              ),
            ),
          );
        });
      },
      menuChildren: items,
      style: MenuStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color(0xff000b2b).withOpacity(0.6)),
      ),
    );
  }
}

/// 判斷手勢是否在元件上
class MouseRegionCustomWidget extends ConsumerWidget {
  MouseRegionCustomWidget(
      {super.key, required this.builder, this.onEnter, this.onExit});

  final Widget Function(PointerEvent isHovered) builder;

  final void Function(PointerEnterEvent event)? onEnter;

  final void Function(PointerExitEvent event)? onExit;

  /// 滑鼠狀態Provider
  final StateNotifierProvider<MouseRegionStateNotifier, PointerEvent>
      mouseRegionProvider =
      StateNotifierProvider((ref) => MouseRegionStateNotifier());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final notifier = ref.read(mouseRegionProvider.notifier);

    final PointerEvent event = ref.watch(mouseRegionProvider);

    return MouseRegion(
      onEnter: (event) {
        onEnter != null ? onEnter!(event) : ();
        notifier.onEnter();
      },
      onExit: (event) {
        onExit != null ? onExit!(event) : ();
        notifier.onExit();
      },
      child: builder(event),
    );
  }
}

/// 全螢幕選單按鈕
class FullScreenMenuBtnPage extends ConsumerWidget {
  const FullScreenMenuBtnPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

    final bool isShowFullScreenMenu =
        ref.watch(isOpenAppBarMenuBtnPageProvider);

    return isShowFullScreenMenu
        ? Container(
            color: const Color.fromARGB(255, 23, 57, 117).withOpacity(0.9),
            child: Stack(
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      // 最左邊間距
                      const SizedBox(width: 16),
                      const _Logo(),
                      const Spacer(flex: 5),
                      // 三條 or 最右邊間距
                      AnimationMenuBtn(isClose: true, notifier: notifier),
                      const SizedBox(width: 19.7),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: MainMenu.values
                        .map(
                          (e) => TextButton(
                            onPressed: () => debugPrint(e.value),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Text(
                                e.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
