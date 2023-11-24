import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:qpp_example/utils/shared_Prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 本地資料庫
  await SharedPrefs.init();

  // 多語系套件
  await EasyLocalization.ensureInitialized();

  // 建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  usePathUrlStrategy(); // flutter_web_plugins

  HttpService service = HttpService.instance; // dio
  service.initDio();

  runApp(
    EasyLocalization(
      // 支援的語系, 從 QppLocales 直接取出
      supportedLocales: QppLocales.supportedLocales,
      // 預設語系
      startLocale: const Locale('zh', 'TW'),
      // 當前語系缺少翻譯時, 使用此語系
      fallbackLocale: const Locale('zh', 'TW'),
      path: 'assets/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      routerConfig: QppGoRouter.router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
