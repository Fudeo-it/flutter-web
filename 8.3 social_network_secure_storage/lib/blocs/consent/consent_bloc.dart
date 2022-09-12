import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/repositories/consent_repository.dart';

part 'consent_event.dart';
part 'consent_state.dart';

class ConsentBloc extends Bloc<ConsentEvent, ConsentState> {
  final ConsentRepository consentRepository;

  ConsentBloc({required this.consentRepository}) : super(UndefinedConsent()) {
    on<AllowConsentEvent>(_mapAllowConsentEventToState);
    on<DenyConsentEvent>(_mapDenyConsentEventToState);
    on<GetConsentEvent>(_mapGetConsentEventToState);
  }

  void allowConsent() => add(AllowConsentEvent());

  void denyConsent() => add(DenyConsentEvent());

  void getConsent() => add(GetConsentEvent());

  void _mapAllowConsentEventToState(_, Emitter<ConsentState> emit) async {
    await consentRepository.allowConsent();
    emit(AllowedConsent());
  }

  void _mapDenyConsentEventToState(_, Emitter<ConsentState> emit) async {
    await consentRepository.denyConsent();
    emit(DeniedConsent());
  }

  void _mapGetConsentEventToState(_, Emitter<ConsentState> emit) async {
    final consent = await consentRepository.consent;

    if (consent != null) {
      if (consent) {
        emit(AllowedConsent());
      } else {
        emit(DeniedConsent());
      }
    } else {
      emit(UndefinedConsent());
    }
  }
}
