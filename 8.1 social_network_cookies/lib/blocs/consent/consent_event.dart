part of 'consent_bloc.dart';

abstract class ConsentEvent extends Equatable {
  const ConsentEvent();

  @override
  List<Object?> get props => [];
}

class AllowConsentEvent extends ConsentEvent {}

class DenyConsentEvent extends ConsentEvent {}

class GetConsentEvent extends ConsentEvent {}
