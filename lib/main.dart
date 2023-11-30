import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/extension/string/text.dart';
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
      startLocale: startLocale,
      // const Locale('zh', 'TW'),
      // 當前語系缺少翻譯時, 使用此語系
      fallbackLocale: const Locale('zh', 'TW'),
      path: 'assets/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

Locale get startLocale {
  // String lang = Uri.base.queryParameters['lang'] ?? "";
  // if (lang.isNotEmpty) {
  //   var keys = lang.split('_');
  //   return Locale(keys[0], keys[1]);
  // }
  return const Locale('zh', 'TW');
}

// initSetting() {
//   var url = Uri.base;
//   var params = url.queryParameters;
//   print('object');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      routerConfig: QppGoRouter.router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
