import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/common_ui/qpp_background.dart';

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
    debugPrint('MyHomePage build');

    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true, // 設定可以在appBar後面擴充body
          appBar: qppAppBar(fullScreenMenuBtnPageStateProvider),
          body: backgroundWidgth(child: child),
        ),
        FullScreenMenuBtnPage(fullScreenMenuBtnPageStateProvider),
      ],
    );
  }
}