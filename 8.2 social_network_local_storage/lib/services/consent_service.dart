import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
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

class LocalStorageConsentService implements ConsentService {
  static const _kAllowConsentKey = 'ALLOW_CONSENT';

  final Future<SharedPreferences> sharedPrefFuture;
  SharedPreferences? _instance;

  LocalStorageConsentService({required this.sharedPrefFuture});

  @override
  FutureOr<void> allowConsent() async {
    (await preferences).setBool(_kAllowConsentKey, true);
  }

  @override
  FutureOr<bool?> get consent async =>
      (await preferences).getBool(_kAllowConsentKey);

  @override
  FutureOr<void> denyConsent() async {
    (await preferences).setBool(_kAllowConsentKey, false);
  }

  FutureOr<SharedPreferences> get preferences async =>
      _instance ??= await sharedPrefFuture;
}
