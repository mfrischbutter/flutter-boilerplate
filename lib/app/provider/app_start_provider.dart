// Package imports:
import 'package:flutter_boilerplate/app/widget/app.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/route/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStartProvider = Provider((ref) {
  return AppStartNotifier(ref.read);
});

class AppStartNotifier {
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);
  final Reader _reader;

  AppStartNotifier(
    this._reader,
  ) : super() {
    _init();
  }

  void _init() async {
    final token = await _tokenRepository.fetchToken();

    if (token != null) {
      initServices();
      _reader(routerProvider).replace(const HomeRoute());
    } else {
      _reader(routerProvider).replace(const LoginRoute());
    }
  }

  Future<void> initServices() async {
    // init data services
  }
}
