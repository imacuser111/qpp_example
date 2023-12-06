import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_framework/qpp_main_framework.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/error_page/model/error_page_model.dart';
import 'package:qpp_example/page/error_page/view/error_page.dart';
import 'package:qpp_example/page/home/view/home_page.dart';
import 'package:qpp_example/page/user_information/view/user_information.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/display_url.dart';

/// QPP路由
class QppGoRouter {
  // -----------------------------------------------------------------------------
  // Home
  // -----------------------------------------------------------------------------
  /// 主頁
  static const String home = '/';

  /// 個人資訊頁
  static const String information = 'information';

  /// 物品資訊頁
  static const String commodityInfo = 'commodity_info';

  /// 物品出示頁
  static const String commodityWithToken = 'commodity_with_token';

  /// 跳轉頁
  static const String go = 'go';

  /// 隱私權政策頁(只有home有)
  static const String privacy = 'privacy';

  /// 使用者條款頁(只有home有)
  static const String term = 'term';

  /// nft教學頁(只有home有)
  static const String nftInfoTeach = 'nft_info_teach';

  // static const String membershipFetch = 'membership_fetch';

  // -----------------------------------------------------------------------------
  // App
  // -----------------------------------------------------------------------------
  /// 主頁
  static const String app = 'app';

  /// 個人資訊頁
  static const String appInformation = '$app/$information';

  /// 物品資訊頁
  static const String appCommodityInfo = '$app/$commodityInfo';

  /// 物品出示頁
  static const String appCommodityWithToken = '$app/$commodityWithToken';

  /// 跳轉頁
  static const String appGo = '$app/$go';

  /// nft物品資訊頁(只有app有)
  static const String nftInfo = 'nft_info';

  /// 外部登入(只有app有)
  static const String vendorLogin = 'vendor_login';

  /// 動態牆登入授權頁(只有app有)
  static const String loginAuth = 'login_auth';

  // static const String appMembershipFetch = '$app/$membershipFetch';

  /// 取語系參數
  static Locale get getLocaleFromPath {
    String lang = Uri.base.queryParameters['lang'] ?? "";
    if (lang.isNotEmpty && lang.contains('_')) {
      var keys = lang.split('_');
      // 檢查是否有支援
      Locale locale = Locale(keys[0], keys[1].toUpperCase());
      if (QppLocales.supportedLocales.contains(locale)) {
        debugPrint('Set Locale $lang');
        return locale;
      }
    }
    return const Locale('zh', 'TW');
  }

  // -----------------------------------------------------------------------------
  /// The route configuration.
  // -----------------------------------------------------------------------------
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: <RouteBase>[
      GoRoute(
        // 首頁
        path: home,
        name: home,
        builder: (BuildContext context, GoRouterState state) {
          Locale locale = getLocaleFromPath;
          // context 設定 locale
          context.setLocale(locale);
          // 更新網址列
          DisplayUrl.updateParam('lang', locale.toString());
          return const MainFramework(child: HomePage());
        },
        routes: homeRouters +
            _getRouters(home) +
            [
              GoRoute(
                path: app,
                name: app,
                builder: (context, state) =>
                    const MainFramework(child: HomePage()),
                routes: appRouters + _getRouters(app),
              )
            ],
      ),
    ],
    errorBuilder: (context, state) {
      return MainFramework(
        child: ErrorPage(type: ErrorPageType.urlIsWrong, url: state.fullURL),
      );
    },
  );

  // -----------------------------------------------------------------------------
  /// Home路由
  // -----------------------------------------------------------------------------
  static List<RouteBase> homeRouters = <RouteBase>[
    // 隱私權政策頁(只有home有)
    GoRoute(
      path: privacy,
      name: privacy,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('隱私權政策頁'))),
    ),
    // 使用者條款頁(只有home有)
    GoRoute(
      path: term,
      name: term,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('使用者條款頁'))),
    ),
    // nft教學頁(只有home有)
    GoRoute(
      path: nftInfoTeach,
      name: nftInfoTeach,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('nft教學頁'))),
    ),
  ];

  // -----------------------------------------------------------------------------
  /// App路由
  // -----------------------------------------------------------------------------
  static List<RouteBase> appRouters = <RouteBase>[
    // 外部登入(只有app有)
    GoRoute(
      path: vendorLogin,
      name: vendorLogin,
      builder: (BuildContext context, GoRouterState state) => MainFramework(
          child: ErrorPage(
              type: ErrorPageType.troubleshootingInstructions,
              url: state.fullURL)),
    ),
    // nft物品資訊頁(只有app有)
    GoRoute(
      path: nftInfo,
      name: nftInfo,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('nft物品資訊頁'))),
    ),
    // 動態牆登入授權頁(只有app有)
    GoRoute(
      path: loginAuth,
      name: loginAuth,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('動態牆登入授權頁'))),
    ),
  ];

  // -----------------------------------------------------------------------------
  /// 共用路徑
  // -----------------------------------------------------------------------------
  static List<RouteBase> _getRouters(String name) {
    final bool isHome = name == home;

    return <RouteBase>[
      // 個人資訊頁
      GoRoute(
        path: information,
        name: isHome ? information : appInformation,
        builder: (BuildContext context, GoRouterState state) {
          final data =
              UniversalLinkParamData.fromJson(state.uri.queryParameters);
          return MainFramework(
            child: UserInformationOuterFrame(
                userID: data.phoneNumber ?? "", url: state.fullURL),
          );
        },
      ),
      // 物品資訊頁
      GoRoute(
        path: commodityInfo,
        name: isHome ? commodityInfo : appCommodityInfo,
        builder: (BuildContext context, GoRouterState state) =>
            MainFramework(child: CommodityInfoPage(routerState: state)),
      ),
      // 物品出示頁
      GoRoute(
        path: commodityWithToken,
        name: isHome ? commodityWithToken : appCommodityWithToken,
        builder: (BuildContext context, GoRouterState state) =>
            MainFramework(child: CommodityInfoPage(routerState: state)),
      ),
      // 跳轉頁
      GoRoute(
        path: go,
        name: isHome ? go : appGo,
        builder: (BuildContext context, GoRouterState state) =>
            const MainFramework(child: Center(child: Text('跳轉頁'))),
      ),
    ];
  }
}

extension GoRouterStateExtension on GoRouterState {
  /// 完整網址
  String get fullURL => ServerConst.routerHost + uri.toString();
}
