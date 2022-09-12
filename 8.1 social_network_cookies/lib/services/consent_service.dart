import 'dart:async';

import 'package:social_network/services/cookie_service.dart';

abstract class ConsentService {
  FutureOr<void> allowConsent();

  FutureOr<void> denyConsent();

  FutureOr<bool?> get consent;
}

class CookieConsentService implements ConsentService {
  static const _kAllowConsentKey = 'ALLOW_CONSENT';
  final CookieService cookieService;

  CookieConsentService({required this.cookieService});

  @override
  FutureOr<void> allowConsent() {
    cookieService.setCookie(_kAllowConsentKey, 'true');
  }

  @override
  FutureOr<bool?> get consent {
    final value = cookieService.getCookie(_kAllowConsentKey);

    if (value != null) {
      return 'true' == value;
    }

    return null;
  }

  @override
  FutureOr<void> denyConsent() {
    cookieService.setCookie(_kAllowConsentKey, 'false');
  }
}
