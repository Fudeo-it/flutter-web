import 'dart:async';

abstract class ConsentService {
  FutureOr<void> allowConsent();

  FutureOr<void> denyConsent();

  FutureOr<bool?> get consent;
}
