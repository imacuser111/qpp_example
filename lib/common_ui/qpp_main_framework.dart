import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/utils/screen.dart';

/// 主框架
class MainFramework extends StatelessWidget {
  MainFramework({super.key, required this.child});

  final Widget child;

  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider = StateNotifierProvider((ref) {
    return FullScreenMenuBtnPageStateNotifier();
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _MainScaffold(
            fullScreenMenuBtnPageStateProvider:
                fullScreenMenuBtnPageStateProvider,
            child: child),
        FullScreenMenuBtnPage(fullScreenMenuBtnPageStateProvider),
      ],
    );
  }
}

/// 主鷹架
class _MainScaffold extends StatelessWidget {
  const _MainScaffold(
      {required this.child, required this.fullScreenMenuBtnPageStateProvider});

  final Widget child;
  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider;

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());
    return Scaffold(
      extendBodyBehindAppBar: true, // 設定可以在appBar後面擴充body
      appBar: qppAppBar(fullScreenMenuBtnPageStateProvider,
          height: _getAppBarHeight(context)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('desktop-bg-kv.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }

  /// 獲取螢幕高度
  double _getAppBarHeight(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth.determineScreenStyle() != ScreenStyle.desktop) {
      return 60.0;
    } else {
      return 100.0;
    }
  }
}
