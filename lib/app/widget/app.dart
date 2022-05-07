import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_boilerplate/shared/route/router.gr.dart';
import 'package:flutter_boilerplate/shared/route/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider((_) => AppRouter(GlobalKey<NavigatorState>()));

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appRouter = ref.read(routerProvider);
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AppRouteObserver()],
      ),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
