// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_boilerplate/app/widget/splash_screen.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/widget/routes.dart';
import 'package:flutter_boilerplate/feature/home/widget/routes.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {}
}

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    homeRouter,
    loginRoute,
  ],
)
class $AppRouter {}
