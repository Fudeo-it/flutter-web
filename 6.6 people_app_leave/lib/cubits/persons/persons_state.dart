part of 'persons_cubit.dart';

abstract class PersonsState extends Equatable {
  const PersonsState();

  @override
  List<Object> get props => [];
}

class LoadingPersonsState extends PersonsState {}

class LoadedPersonsState extends PersonsState {
  final List<Person> people;

  const LoadedPersonsState(this.people);

  @override
  List<Object> get props => [people];
}

class ErrorPersonsState extends PersonsState {}
