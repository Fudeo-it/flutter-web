import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc({
    required this.userRepository,
  }) : super(NotSignedUpState()) {
    on<SignUpEvent>((event, emit) async {
      emit(SigningUpState());

      User? user;
      try {
        user = await userRepository.signUp(
          name: event.name,
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        emit(SignUpErrorState());
      }

      if (user != null) {
        emit(SignedUpState());
      }
    });
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) =>
      add(
        SignUpEvent(
          name: name,
          email: email,
          password: password,
        ),
      );
}
