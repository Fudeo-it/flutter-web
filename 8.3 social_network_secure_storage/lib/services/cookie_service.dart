import 'dart:html' as html;

class CookieService {
  void setCookie(String key, String value) {
    html.document.cookie = '$key=$value';
  }

  String? getCookie(String key) {
    final cookie = html.document.cookie;
    final cookies =
        cookie?.split('; ').fold<Map<String, String>>({}, (map, item) {
      final split = item.split('=');

      if (split.length == 2) {
        map.addEntries([MapEntry(split[0], split[1])]);
      }

      return map;
    });

    return cookies?[key];
  }
}
