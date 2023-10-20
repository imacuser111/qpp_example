import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
// 建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  usePathUrlStrategy(); // flutter_web_plugins

  HttpService service = HttpService.instance; // dio
  service.initDio();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

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
          body: child,
        ),
        FullScreenMenuBtnPage(fullScreenMenuBtnPageStateProvider),
      ],
    );
  }
}

/// 背景圖片Widgth
Widget backgroundWidgth({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('desktop-bg-kv.webp'),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}
