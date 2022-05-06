// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/repository/auth_repository.dart';

final authProvider = Provider((ref) {
  return AuthProvider(ref.read);
});

class AuthProvider {
  AuthProvider(this._reader) : super();

  final Reader _reader;
  late final AuthRepository _loginRepository = _reader(authRepositoryProvider);

  Future<void> login(String email, String password) async {
    await _loginRepository.login(email, password);
  }
}
