import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit({required this.userRepository}) : super(CheckAuthenticationState());

  void checkAuthenticationState() async {
    final token = await userRepository.currentUser;

    emit(token != null ? AuthenticatedState(token) : NotAuthenticatedState());
  }

  void authenticate(User user) => emit(AuthenticatedState(user));

  void logout() async {
    await userRepository.signOut();

    emit(NotAuthenticatedState());
  }
}
