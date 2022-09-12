import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:people_app/models/person.dart';
import 'package:people_app/repositories/people_repository.dart';

part 'add_person_state.dart';

class AddPersonCubit extends Cubit<AddPersonState> {
  final PeopleRepository peopleRepository;

  AddPersonCubit({required this.peopleRepository})
      : super(AddPersonDefaultState());

  void addPerson({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String address,
    required String city,
    required String state,
  }) async {
    emit(AddingPersonState());

    try {
      final person = await peopleRepository.save(
        firstName: firstName,
        lastName: lastName,
        birthDate: DateFormat('dd/MM/yyyy').parse(birthDate),
        address: address,
        city: city,
        state: state,
      );

      emit(AddedPersonState(person));
    } catch (e) {
      emit(ErrorAddPersonState());
    }
  }
}
