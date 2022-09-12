import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_app/models/person.dart';
import 'package:people_app/repositories/people_repository.dart';

part 'persons_state.dart';

class PersonsCubit extends Cubit<PersonsState> {
  final PeopleRepository peopleRepository;

  PersonsCubit({required this.peopleRepository}) : super(LoadingPersonsState());

  void fetchPeople() async {
    emit(LoadingPersonsState());

    try {
      final people = await peopleRepository.people;
      emit(LoadedPersonsState(people));
    } catch (e) {
      emit(ErrorPersonsState());
    }
  }
}
