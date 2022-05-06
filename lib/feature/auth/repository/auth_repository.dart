// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/util/validator.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> login(String email, String password);
}

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.read));

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<AuthState> login(String email, String password) async {
    if (!Validator.isValidPassWord(password)) {
      return const AuthState.error(
          AppException.errorWithMessage('Minimum 8 characters required'));
    }
    if (!Validator.isValidEmail(email)) {
      return const AuthState.error(
          AppException.errorWithMessage('Please enter a valid email address'));
    }
    final params = {
      'email': email,
      'password': password,
    };
    final loginResponse = await _api.post('login', jsonEncode(params));

    return loginResponse.when(success: (success) async {
      final tokenRepository = _reader(tokenRepositoryProvider);

      final token = Token.fromJson(success);

      await tokenRepository.saveToken(token);

      return const AuthState.authenticated();
    }, error: (error) {
      return AuthState.error(error);
    });
  }
}