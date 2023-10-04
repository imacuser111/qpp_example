import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/qpp_app_bar/qpp_app_bar_model.dart';
import 'package:qpp_example/utils/screen.dart';

AppBar qppAppBar(
    StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
        fullScreenMenuBtnPageStateProvider) {
  return AppBar(
    toolbarHeight: 100,
    backgroundColor: const Color(0xff000b2b).withOpacity(0.6),
    title: QppAppBarTitle(fullScreenMenuBtnPageStateProvider),
  );
}

class QppAppBarTitle extends ConsumerWidget with QppAppBarTitleExtension {
  const QppAppBarTitle(this.fullScreenMenuBtnPageStateProvider, {super.key});

  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('1231311');

    final size = MediaQuery.of(context).size;

    final notifier = ref.read(fullScreenMenuBtnPageStateProvider.notifier);

    final bool isShowFullScreenMenu =
        ref.watch(fullScreenMenuBtnPageStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSmallTypesetting(size.width)
          ? ()
          : isShowFullScreenMenu
              ? notifier.toggle()
              : ();
    });

    return Row(
      children: [
        // 最左邊間距
        spacing(200),
        isShowFullScreenMenu ? Container() : logo(),
        // QPP -> Button 間距
        Expanded(flex: 2, child: spacing(466)),
        // 選單按鈕
        menuRow(size.width),
        // 語系
        Padding(
          padding: const EdgeInsets.only(left: 74),
          child: languageDropdownMenu(),
        ),
        // 三條 or 最右邊間距
        isShowFullScreenMenu
            ? spacing(10)
            : isSmallTypesetting(size.width)
                ? animationMenuBtn(false, notifier)
                : spacing(10),
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
  Widget logo() {
    return IconButton(
        icon: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 148),
      child: Image.asset(
        'desktop-pic-qpp-logo-01.png',
        width: 148.getRealWidth(),
        scale: 46 / 148,
      ),
    ), onPressed: () => debugPrint('123'),);
  }

  /// 選單按鈕(Row)
  Widget menuRow(double width) {
    if (isSmallTypesetting(width)) {
      return const Spacer();
    }

    return Row(
      children: MainMenu.values
          .map(
            (e) => TextButton(
              onPressed: () => debugPrint(e.value),
              child: Text(
                e.value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }

  /// 語系下拉選單
  Widget languageDropdownMenu() {
    MenuController menuController = MenuController();

    // Item
    List<MouseRegion> items = Language.values
        .map((e) => MouseRegion(
              onEnter: (event) => menuController.open(),
              onExit: (event) => menuController.close(),
              child: DropdownMenuItem(
                value: e.value,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: () {
                          menuController.close();
                          debugPrint(e.value);
                        },
                        child: Text(
                          e.value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    return MouseRegion(
      onEnter: (event) => menuController.open(),
      onExit: (event) => menuController.close(),
      child: MenuAnchor(
        builder: (context, controller, child) {
          menuController = controller;

          return IconButton(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: const Row(
                children: [
                  Icon(Icons.language, color: Colors.white),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white)
                ],
              ));
        },
        menuChildren: items,
        style: MenuStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color(0xff000b2b).withOpacity(0.6)),
        ),
      ),
    );
  }

  /// animationMenuBtn(三條or關閉)
  Widget animationMenuBtn(
      bool isClose, FullScreenMenuBtnPageStateNotifier notifier) {
    return IconButton(
      onPressed: () => notifier.toggle(),
      icon: isClose
          ? const Icon(Icons.close, color: Colors.white)
          : const Icon(Icons.menu, color: Colors.white),
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
            child: Column(
              children: [
                Row(
                  children: [
                    // 最左邊間距
                    spacing(321),
                    logo(),
                    const Spacer(),
                    // 三條 or 最右邊間距
                    animationMenuBtn(true, notifier),
                    spacing(20),
                  ],
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

/// 全螢幕按鈕選單狀態
class FullScreenMenuBtnPageStateNotifier extends StateNotifier<bool> {
  FullScreenMenuBtnPageStateNotifier() : super(false);

  void toggle() {
    state = !state; // 是否顯示全螢幕選單
  }
}
