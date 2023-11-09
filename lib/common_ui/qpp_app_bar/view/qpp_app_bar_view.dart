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

AppBar qppAppBar(
    StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
        fullScreenMenuBtnPageStateProvider,
    {required double height}) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight: height,
    backgroundColor: QppColor.onyx60,
    title: QppAppBarTitle(fullScreenMenuBtnPageStateProvider),
  );
}

class QppAppBarTitle extends ConsumerWidget with QppAppBarTitleExtension {
  QppAppBarTitle(this.fullScreenMenuBtnPageStateProvider, {super.key});

  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(toString());

    final size = MediaQuery.of(context).size;

    final notifier = ref.read(fullScreenMenuBtnPageStateProvider.notifier);

    final bool isShowFullScreenMenu =
        ref.watch(fullScreenMenuBtnPageStateProvider);

    return Row(
      children: [
        // 最左邊間距
        Flexible(child: spacing(200)),
        isShowFullScreenMenu ? Container() : logo(context),
        // QPP -> Button 間距
        // Expanded(child: spacing(466)),
        const Spacer(flex: 5),
        // 選單按鈕
        menuRow(size.width),
        // 語系
        const Padding(
          padding: EdgeInsets.only(left: 74),
          child: LanguageDropdownMenu(),
        ),
        // 三條 or 最右邊間距
        isShowFullScreenMenu
            ? IconButton(
                icon: const Text(''),
                onPressed: () {},
              )
            : isSmallTypesetting(size.width)
                ? AnimationMenuBtn(
                    isClose: false,
                    notifier: notifier,
                  )
                : SizedBox(width: 10.getRealWidth()),
      ],
    );
  }
}

// 是否為小排版
bool isSmallTypesetting(double width) =>
    width.determineScreenStyle() != ScreenStyle.desktop;

mixin QppAppBarTitleExtension {
  /// 間距
  Widget spacing(double width) {
    double realWidth = width.getRealWidth();

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 10, maxHeight: realWidth),
      child: Container(
        width: realWidth,
      ),
    );
  }

  /// QPP Logo
  Widget logo(BuildContext context) {
    return IconButton(
      icon: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 148),
        child: Image.asset(
          'desktop-pic-qpp-logo-01.png',
          width: 148.getRealWidth(),
          scale: 46 / 148,
        ),
      ),
      onPressed: () => context.goNamed("home"),
    );
  }

  /// 選單按鈕(Row)
  Widget menuRow(double width) {
    if (isSmallTypesetting(width)) {
      return const Spacer();
    }

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
  final FullScreenMenuBtnPageStateNotifier notifier;

  @override
  State<StatefulWidget> createState() => _AnimationMenuBtn();
}

class _AnimationMenuBtn extends State<AnimationMenuBtn>
    with TickerProviderStateMixin {
  late bool _isClose;
  late FullScreenMenuBtnPageStateNotifier _notifier;
  late AnimationController _controller;

  int _count = 0;
  final int _targetCount = 1;

  @override
  void initState() {
    super.initState();

    _isClose = widget.isClose;
    _notifier = widget.notifier;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
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
    _controller.dispose();
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
            onPressed: () => _notifier.toggle(),
            icon: _isClose || _count < _targetCount
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
    debugPrint(toString());

    MenuController menuController = MenuController();

    // Item
    List<MouseRegionCustomWidget> items = Language.values
        .map(
          (e) => MouseRegionCustomWidget(
            onEnter: (event) => menuController.open(),
            onExit: (event) => menuController.close(),
            builder: (event) => MenuItemButton(
              onPressed: () {
                context.setLocale(e.locale);
                print('Now change to ${context.locale.toString()}');
                menuController.close();
                debugPrint(e.displayTitle);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  e.displayTitle,
                  style: TextStyle(
                      color: event is PointerEnterEvent
                          ? Colors.amber
                          : Colors.white),
                ),
              ),
            ),
          ),
        )
        .toList();

    return MenuAnchor(
      builder: (context, controller, child) {
        menuController = controller;
        return MouseRegion(
          onEnter: (event) => menuController.open(),
          onExit: (event) => menuController.close(),
          child: IconButton(
            onPressed: () {
              controller.isOpen ? controller.close() : controller.open();
            },
            icon: const Row(
              children: [
                Icon(Icons.language, color: Colors.white),
                Icon(Icons.keyboard_arrow_down, color: Colors.white)
              ],
            ),
          ),
        );
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

  final StateNotifierProvider<MouseRegionStateNotifier, PointerEvent>
      mouseRegionStateNotifier = StateNotifierProvider((ref) {
    return MouseRegionStateNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final notifier = ref.read(mouseRegionStateNotifier.notifier);

    final PointerEvent event = ref.watch(mouseRegionStateNotifier);

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
class FullScreenMenuBtnPage extends ConsumerWidget
    with QppAppBarTitleExtension {
  const FullScreenMenuBtnPage(this.fullScreenMenuBtnPageStateProvider,
      {super.key});

  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(fullScreenMenuBtnPageStateProvider.notifier);

    final bool isShowFullScreenMenu =
        ref.watch(fullScreenMenuBtnPageStateProvider);

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
                      Flexible(child: spacing(200)),
                      logo(context),
                      const Spacer(flex: 5),
                      // 三條 or 最右邊間距
                      AnimationMenuBtn(isClose: true, notifier: notifier),
                      SizedBox(width: 10.getRealWidth()),
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
        : Container();
  }
}
