import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/utils/screen.dart';

AppBar qppAppBar(
    StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
        fullScreenMenuBtnPageStateProvider) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight: 100,
    backgroundColor: const Color(0xff000b2b).withOpacity(0.6),
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
        isShowFullScreenMenu ? Container() : logo(context),
        // QPP -> Button 間距
        Expanded(flex: 2, child: spacing(466)),
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
            (e) => MouseRegionCustomWidget(
              builder: (event) => TextButton(
                onPressed: () => debugPrint(e.value),
                child: Text(
                  e.value,
                  style: TextStyle(
                      color: event is PointerEnterEvent
                          ? Colors.amber
                          : Colors.white),
                ),
              ),
            ),
          )
          .toList(),
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
                menuController.close();
                debugPrint(e.value);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  e.value,
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
    debugPrint(toString());

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
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      // 最左邊間距
                      spacing(200),
                      logo(context),
                      const Spacer(),
                      // 三條 or 最右邊間距
                      animationMenuBtn(true, notifier),
                      spacing(10),
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

// class MyMenuWidget extends StatefulWidget {
//   const MyMenuWidget({super.key});

//   @override
//   State<MyMenuWidget> createState() => _MyMenuWidgetState();
// }

// class _MyMenuWidgetState extends State<MyMenuWidget>
//     with TickerProviderStateMixin {
//   final MenuController _menuController = MenuController();
//   late AnimationController _animationController;
//   late Animation<double> _menuAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300), // 调整动画持续时间
//     );
//     _menuAnimation =
//         Tween<double>(begin: 0, end: 1).animate(_animationController);
//   }

//   void _toggleMenu() {
//     if (_menuController.isOpen) {
//       _animationController.reverse(); // 反向播放动画以关闭菜单
//       _menuController.close();
//     } else {
//       _animationController.forward(); // 正向播放动画以打开菜单
//       _menuController.open();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: _toggleMenu,
//           child: Text('Toggle Menu'),
//         ),
//         AnimatedBuilder(
//           animation: _menuAnimation, // 使用自己创建的动画
//           builder: (context, child) {
//             return SizedBox(
//               height: _menuAnimation.value * 200, // 菜单高度根据动画值变化
//               child: MenuAnchor(
//                 controller: _menuController,
//                 menuChildren: [
//                   Container(
//                     width: 200,
//                     color: Colors.blue,
//                     child: Center(
//                       child: Text(
//                         'Menu Content',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//                 child: child,
//               ),
//             );
//           },
//           child: Container(
//             width: 200,
//             height: 50,
//             color: Colors.green,
//             child: Center(
//               child: Text(
//                 'Main Content',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose(); // 在不再使用时销毁动画控制器
//     super.dispose();
//   }
// }
