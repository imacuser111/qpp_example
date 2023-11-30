import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/utils/screen.dart';

/// 主框架
class MainFramework extends StatelessWidget {
  const MainFramework({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _MainScaffold(child: child),
        const FullScreenMenuBtnPage(),
      ],
    );
  }
}

/// 主鷹架
class _MainScaffold extends StatelessWidget {
  const _MainScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final Size screenSize = MediaQuery.of(context).size;
    final ScreenStyle screenStyle = screenSize.width.determineScreenStyle();

    return SelectionArea(
      child: Scaffold(
        extendBodyBehindAppBar: true, // 設定可以在appBar後面擴充body
        appBar: qppAppBar(screenStyle),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                screenStyle.isDesktop
                    ? 'assets/desktop_bg_kv.png'
                    : 'assets/mobile-bg-kv.webp',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
