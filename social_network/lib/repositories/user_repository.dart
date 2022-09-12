import 'package:logger/logger.dart';
import 'package:social_network/models/sign_in_request.dart';
import 'package:social_network/models/sign_up_request.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/services/auth_service.dart';

class UserRepository {
  final AuthService authService;
  final Logger logger;

  UserRepository({
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

  Future<void> signOut() async {}

  Future<User?> get currentUser async {
    return null;
  }
}
