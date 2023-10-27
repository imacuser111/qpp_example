import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_main_framework.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/qpp_home/view/qpp_home_page.dart';
import 'package:qpp_example/page/qpp_info_body/view/qpp_info_body_main.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MainFramework(
          child: const HomePage(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'information',
          path: 'app/information',
          builder: (BuildContext context, GoRouterState state) {
            final data =
                UniversalLinkParamData.fromJson(state.uri.queryParameters);
            return MainFramework(
              child: InformationOuterFrame(userID: data.phoneNumber ?? ""),
            );
          },
        ),
        GoRoute(
          name: 'commodity_info',
          path: 'app/commodity_info',
          builder: (BuildContext context, GoRouterState state) {
            // final data =
            //     UniversalLinkParamData.fromJson(state.uri.queryParameters);
            return MainFramework(
              child: CommodityInfoPage(
                routerState: state,
              ),
            );
          },
        )
      ],
    ),
  ],
);
