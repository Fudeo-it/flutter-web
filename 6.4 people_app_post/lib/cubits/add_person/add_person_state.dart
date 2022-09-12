part of 'add_person_cubit.dart';

abstract class AddPersonState extends Equatable {
  const AddPersonState();

  @override
  List<Object> get props => [];
}

class AddPersonDefaultState extends AddPersonState {}

class AddingPersonState extends AddPersonState {}

class AddedPersonState extends AddPersonState {
  final Person person;

  const AddedPersonState(this.person);

  @override
  List<Object> get props => [person];
}

class ErrorAddPersonState extends AddPersonState {}
