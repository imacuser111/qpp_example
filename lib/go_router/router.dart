import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/main.dart';
import 'package:qpp_example/qpp_info_body/view/qpp_info_body_main.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MainFramework(
          child: const Text('HomePage'),
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
              child: InformationOuterFrame(
                userID: data.phoneNumber ?? "",
              ),
            );
          },
        )
      ],
    ),
  ],
);
