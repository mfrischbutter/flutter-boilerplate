// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Project imports:
import 'package:flutter_boilerplate/shared/constants/store_key.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';

abstract class TokenRepositoryProtocol {
  Future<void> remove();
  Future<void> saveToken(Token token);
  Future<Token?> fetchToken();
}

final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepository();
});

class TokenRepository implements TokenRepositoryProtocol {
  TokenRepository();

  Token? _token;

  @override
  Future<void> remove() async {
    _token = null;
    const storage = FlutterSecureStorage();
    await storage.delete(key: StoreKey.token.toString());
  }

  @override
  Future<void> saveToken(Token token) async {
    _token = token;
    const storage = FlutterSecureStorage();
    await storage.write(
        key: StoreKey.token.toString(), value: tokenToJson(token));
  }

  @override
  Future<Token?> fetchToken() async {
    if (_token != null) {
      return _token;
    }

    String? tokenValue;

    const storage = FlutterSecureStorage();
    tokenValue = await storage.read(key: StoreKey.token.toString());
    if (tokenValue != null) {
      _token = tokenFromJson(tokenValue);
    }

    return _token;
  }
}
