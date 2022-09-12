part of 'consent_bloc.dart';

abstract class ConsentState extends Equatable {
  const ConsentState();

  @override
  List<Object> get props => [];
}

class UndefinedConsent extends ConsentState {}

class AllowedConsent extends ConsentState {}

class DeniedConsent extends ConsentState {}
