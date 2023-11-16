import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_framework/qpp_main_framework.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/qpp_home/view/qpp_home_page.dart';
import 'package:qpp_example/page/user_information/view/user_information.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

/// QPP路由
class QppGoRouter {
  // -----------------------------------------------------------------------------
  // Home
  // -----------------------------------------------------------------------------
  /// 主頁
  static const String home = 'home';

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

  /// 粉絲卡挑戰頁(只有home有)
  static const String fanCardChallenge = '/events/FanCardChallenge';

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
  static const String appNftInfo = '$app/nft_info';

  /// 動態牆登入授權頁(只有app有)
  static const String appLoginAuth = '$app/login_auth';

  // static const String appMembershipFetch = '$app/$membershipFetch';

  // -----------------------------------------------------------------------------
  /// The route configuration.
  // -----------------------------------------------------------------------------
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        // 首頁
        path: '/',
        name: home,
        builder: (BuildContext context, GoRouterState state) =>
            const MainFramework(child: HomePage()),
        routes: homeRouters +
            _getRouters(home) +
            [
              GoRoute(
                  path: app,
                  name: app,
                  builder: (context, state) =>
                      const MainFramework(child: HomePage()),
                  routes: appRouters + _getRouters(app))
            ],
      ),
    ],
    errorBuilder: (context, state) => const Center(child: Text('錯誤頁')),
  );

  /// Home路由
  static List<RouteBase> homeRouters = <RouteBase>[
    // -----------------------------------------------------------------------------
    // 隱私權政策頁(只有home有)
    // -----------------------------------------------------------------------------
    GoRoute(
      path: privacy,
      name: privacy,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('隱私權政策頁'))),
    ),
    // -----------------------------------------------------------------------------
    // 使用者條款頁(只有home有)
    // -----------------------------------------------------------------------------
    GoRoute(
      path: term,
      name: term,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('使用者條款頁'))),
    ),
    // -----------------------------------------------------------------------------
    // nft教學頁(只有home有)
    // -----------------------------------------------------------------------------
    GoRoute(
      path: nftInfoTeach,
      name: nftInfoTeach,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('nft教學頁'))),
    ),
    // -----------------------------------------------------------------------------
    // 粉絲卡挑戰頁(只有home有)
    // -----------------------------------------------------------------------------
    // GoRoute(
    //   path: fanCardChallenge,
    //   name: fanCardChallenge,
    //   builder: (BuildContext context, GoRouterState state) =>
    //       const MainFramework(child: Center(child: Text('粉絲卡挑戰頁'))),
    // ),
  ];

  /// App路由
  static List<RouteBase> appRouters = <RouteBase>[
    // -----------------------------------------------------------------------------
    // nft物品資訊頁(只有app有)
    // -----------------------------------------------------------------------------
    GoRoute(
      path: appNftInfo,
      name: appNftInfo,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('nft物品資訊頁'))),
    ),
    // -----------------------------------------------------------------------------
    // 動態牆登入授權頁(只有app有)
    // -----------------------------------------------------------------------------
    GoRoute(
      path: appLoginAuth,
      name: appLoginAuth,
      builder: (BuildContext context, GoRouterState state) =>
          const MainFramework(child: Center(child: Text('動態牆登入授權頁'))),
    ),
  ];

  /// 共用路徑
  static List<RouteBase> _getRouters(String name) {
    final bool isHome = name == home;

    return <RouteBase>[
      // -----------------------------------------------------------------------------
      // 個人資訊頁
      // -----------------------------------------------------------------------------
      GoRoute(
        path: information,
        name: isHome ? information : appInformation,
        builder: (BuildContext context, GoRouterState state) {
          final data =
              UniversalLinkParamData.fromJson(state.uri.queryParameters);
          return MainFramework(
            child: UserInformationOuterFrame(
                userID: data.phoneNumber ?? "", uri: state.uri.toString()),
          );
        },
      ),
      // -----------------------------------------------------------------------------
      // 物品資訊頁
      // -----------------------------------------------------------------------------
      GoRoute(
        path: commodityInfo,
        name: isHome ? commodityInfo : appCommodityInfo,
        builder: (BuildContext context, GoRouterState state) =>
            MainFramework(child: CommodityInfoPage(routerState: state)),
      ),
      // -----------------------------------------------------------------------------
      // 物品出示頁
      // -----------------------------------------------------------------------------
      GoRoute(
        path: commodityWithToken,
        name: isHome ? commodityWithToken : appCommodityWithToken,
        builder: (BuildContext context, GoRouterState state) =>
            MainFramework(child: CommodityInfoPage(routerState: state)),
      ),
      // -----------------------------------------------------------------------------
      // 跳轉頁
      // -----------------------------------------------------------------------------
      GoRoute(
        path: go,
        name: isHome ? go : appGo,
        builder: (BuildContext context, GoRouterState state) =>
            const MainFramework(child: Center(child: Text('跳轉頁'))),
      ),
    ];
  }
}
