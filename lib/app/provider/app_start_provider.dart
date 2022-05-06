// Package imports:
import 'package:flutter_boilerplate/app/widget/app.dart';
import 'package:flutter_boilerplate/shared/route/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';

final appStartProvider =
    StateNotifierProvider<AppStartNotifier, AppStartState>((ref) {
  final loginState = ref.watch(authProvider);

  late AppStartState appStartState;
  appStartState = loginState is AppAuthenticated
      ? const AppStartState.authenticated()
      : const AppStartState.initial();

  return AppStartNotifier(appStartState, ref.read);
});

class AppStartNotifier extends StateNotifier<AppStartState> {
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);
  final Reader _reader;

  AppStartNotifier(
    AppStartState appStartState,
    this._reader,
  ) : super(appStartState) {
    _init();
  }

  void _init() async {
    final token = await _tokenRepository.fetchToken();

    if (token != null) {
      if (mounted) {
        // state = const AppStartState.authenticated();
        _reader(routerProvider).replace(const HomeRoute());
      }
    } else {
      if (mounted) {
        _reader(routerProvider).replace(LoginRoute());
      }
    }
  }
}
