// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_boilerplate/app/widget/splash_screen.dart' as _i1;
import 'package:flutter_boilerplate/feature/auth/widget/login_screen.dart'
    as _i3;
import 'package:flutter_boilerplate/feature/home/widget/home_screen.dart'
    as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    HomeRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    LoginRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.LoginScreen());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(SplashRoute.name, path: '/'),
        _i4.RouteConfig(HomeRoute.name, path: '/home'),
        _i4.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}
