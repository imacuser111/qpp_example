import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_menu/c_menu_anchor.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/model/enum/language.dart';
import 'package:qpp_example/utils/qpp_contanst.dart';
import 'package:qpp_example/utils/screen.dart';

AppBar qppAppBar(ScreenStyle screenStyle) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight: screenStyle.isDesktopStyle
        ? kToolbarDesktopHeight
        : kToolbarMobileHeight,
    backgroundColor: QppColor.onyx60,
    title: screenStyle.isDesktopStyle
        ? const _QppAppBarTitle(ScreenStyle.desktop)
        : const _QppAppBarTitle(ScreenStyle.mobile),
    titleSpacing: 0,
  );
}

class _QppAppBarTitle extends ConsumerWidget {
  const _QppAppBarTitle(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final bool isDesktopStyle = screenStyle.isDesktopStyle;

    final bool isOpenAppBarMenuBtnPage =
        ref.watch(isOpenAppBarMenuBtnPageProvider);

    final bool isLogin = ref.watch(isLoginProvider);

    return Row(
      children: [
        // 最左邊間距
        Spacer(flex: isDesktopStyle ? 320 : 28),
        isOpenAppBarMenuBtnPage
            ? const SizedBox.shrink()
            : isDesktopStyle
                ? const _Logo(ScreenStyle.desktop)
                : const _Logo(ScreenStyle.mobile),
        // QPP -> Button 間距
        Spacer(flex: isDesktopStyle ? 527 : 210),
        // 選單按鈕
        isDesktopStyle ? const _MenuBtns() : const SizedBox.shrink(),
        isLogin
            ? Padding(
                padding: const EdgeInsets.only(left: 64),
                child: isDesktopStyle
                    ? const _UserInfo(ScreenStyle.desktop)
                    : const _UserInfo(ScreenStyle.mobile))
            : const SizedBox.shrink(),
        // 語系
        Padding(
          padding: EdgeInsets.only(
              left: isDesktopStyle
                  ? isLogin
                      ? 48
                      : 64
                  : 20),
          child: isDesktopStyle
              ? const LanguageDropdownMenu(ScreenStyle.desktop)
              : const LanguageDropdownMenu(ScreenStyle.mobile),
        ),
        // 三條 or 最右邊間距
        isOpenAppBarMenuBtnPage
            ? const SizedBox(width: 30)
            : isDesktopStyle
                ? const Flexible(child: SizedBox.shrink())
                : const AnimationMenuBtn(isClose: false),
        Spacer(flex: isDesktopStyle ? 319 : 24),
      ],
    );
  }
}

// QPP Logo
class _Logo extends StatelessWidget {
  const _Logo(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final bool isDesktopStyle = screenStyle.isDesktopStyle;

    return IconButton(
      icon: Image.asset(
        'desktop-pic-qpp-logo-01.png',
        width: isDesktopStyle ? 148 : 89,
        scale: 46 / 148,
      ),
      onPressed: () => context.goNamed(QppGoRouter.home),
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
  const AnimationMenuBtn({super.key, required this.isClose});

  final bool isClose;

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
          child: Consumer(builder: (context, ref, child) {
            final notifier = ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

            return IconButton(
              iconSize: 24,
              onPressed: () => notifier.toggle(),
              icon: widget.isClose || _count < _targetCount
                  ? const Icon(Icons.close, color: Colors.white)
                  : const Icon(Icons.menu, color: Colors.white),
            );
          }),
        );
      },
    );
  }
}

/// 使用者資訊
class _UserInfo extends StatelessWidget {
  const _UserInfo(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktopStyle;

    // 控制器狀態Provider
    final StateProvider<bool> isOpenControllerProvider =
        StateProvider((ref) => false);

    return CMenuAnchor(
      list: AppBarUserInfo.values,
      builder: (context, controller, child) {
        return Consumer(
          builder: (context, ref, child) {
            final isOpen = ref.watch(isOpenControllerProvider);
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            Future.microtask(
                () => isOpen ? controller.open() : controller.close());

            return MouseRegion(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              child: child,
            );
          },
          child: Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8),
              isDesktopStyle
                  ? const Text('phoneNumber',
                      style: TextStyle(fontSize: 14, color: Colors.white))
                  : const SizedBox.shrink(),
              isDesktopStyle
                  ? const Icon(Icons.keyboard_arrow_down, color: Colors.white)
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
      isOpenControllerProvider: isOpenControllerProvider,
      onTap: (BuildContext context, WidgetRef ref, _) {
        ref.read(isLoginProvider.notifier).state = false;
      },
    );
  }
}

/// 語系下拉選單
class LanguageDropdownMenu extends StatelessWidget {
  const LanguageDropdownMenu(this.screenStyle, {super.key});

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktopStyle;

    // 控制器狀態Provider
    final StateProvider<bool> isOpenControllerProvider =
        StateProvider((ref) => false);

    return CMenuAnchor(
      list: Language.values,
      builder: (context, controller, child) {
        return Consumer(
          builder: (context, ref, child) {
            final isOpen = ref.watch(isOpenControllerProvider);
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            Future.microtask(
                () => isOpen ? controller.open() : controller.close());

            return MouseRegion(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              child: child,
            );
          },
          child: IconButton(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            icon: Row(
              children: [
                const Icon(Icons.language, color: Colors.white),
                isDesktopStyle
                    ? const Icon(Icons.keyboard_arrow_down, color: Colors.white)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        );
      },
      isOpenControllerProvider: isOpenControllerProvider,
      onTap: (BuildContext context, _, CMeunAnchorData e) {
        context.setLocale((e as Language).locale);
      },
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
    final bool isOpenAppBarMenuBtnPage =
        ref.watch(isOpenAppBarMenuBtnPageProvider);
    final isOpenAppBarMenuBtnNotifier =
        ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

    return isOpenAppBarMenuBtnPage
        ? ColoredBox(
            color: const Color.fromARGB(255, 23, 57, 117).withOpacity(0.9),
            child: Stack(
              children: [
                const SizedBox(
                  height: kToolbarMobileHeight,
                  child: Row(
                    children: [
                      // 最左邊間距
                      SizedBox(width: 29),
                      _Logo(ScreenStyle.mobile),
                      Spacer(),
                      // 三條 or 最右邊間距
                      AnimationMenuBtn(isClose: true),
                      SizedBox(width: 24)
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: MainMenu.values
                        .map(
                          (e) => TextButton(
                            onPressed: () {
                              isOpenAppBarMenuBtnNotifier.toggle();

                              BuildContext? currentContext = e.currentContext;
                              bool isHomePage = currentContext != null;

                              if (!isHomePage) {
                                context.goNamed(QppGoRouter.home);
                              }

                              /// 延遲等待跳轉完，重新抓currentContext
                              Future.delayed(
                                  Duration(milliseconds: isHomePage ? 0 : 300),
                                  () {
                                currentContext = e.currentContext;
                                if (currentContext != null) {
                                  Scrollable.ensureVisible(currentContext!,
                                      duration: const Duration(seconds: 1));
                                }
                              });
                            }.throttleWithTimeout(timeout: 2000),
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
