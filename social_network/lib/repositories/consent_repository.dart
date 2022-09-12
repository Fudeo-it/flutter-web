import 'dart:async';

import 'package:social_network/services/consent_service.dart';

class ConsentRepository {
  final ConsentService consentService;

  ConsentRepository({required this.consentService});

  FutureOr<void> allowConsent() async => await consentService.allowConsent();

  FutureOr<void> denyConsent() async => await consentService.denyConsent();

  FutureOr<bool?> get consent async => await consentService.consent;
}
