// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/feature/auth/widget/sign_in_page.dart';
import 'package:flutter_boilerplate/feature/home/widget/home_screen.dart';
import 'package:flutter_boilerplate/shared/widget/connection_unavailable_widget.dart';
import 'package:flutter_boilerplate/shared/widget/loading_screen.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartProvider);

    return state.maybeWhen(
      initial: () => const LoadingScreen(),
      authenticated: () => HomeScreen(),
      unauthenticated: () => SignInPage(),
      internetUnAvailable: () => const ConnectionUnavailableScreen(),
      orElse: () => const LoadingScreen(),
    );
  }
}
