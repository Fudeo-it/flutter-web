import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:social_network/models/sign_in_request.dart';
import 'package:social_network/models/sign_up_request.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/services/auth_service.dart';

class UserRepository {
  static const _kCurrentUser = 'CURRENT_USER';

  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final Logger logger;

  UserRepository({
    required this.secureStorage,
    required this.authService,
    required this.logger,
  });

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authService.signIn(
        SignInRequest(
          email: email,
          password: password,
        ),
      );

      final encodedJson = user.toJson;
      final json = jsonEncode(encodedJson);

      await secureStorage.write(key: _kCurrentUser, value: json);

      return user;
    } catch (error, stackTrace) {
      logger.e(
        'Failed to sign in with email: $email and password: $password',
        error,
        stackTrace,
      );

      rethrow;
    }
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await authService.signUp(
        SignUpRequest(
          name: name,
          email: email,
          password: password,
        ),
      );
    } catch (error, stackTrace) {
      logger.e(
        'Failed to sign up with name: $name, email: $email and password: $password',
        error,
        stackTrace,
      );

      rethrow;
    }
  }

  Future<void> signOut() async {
    await secureStorage.delete(key: _kCurrentUser);
  }

  Future<User?> get currentUser async {
    final json = await secureStorage.read(key: _kCurrentUser);

    if (json != null) {
      final decodedJson = jsonDecode(json);
      return User.fromJson(decodedJson);
    }

    return null;
  }
}
