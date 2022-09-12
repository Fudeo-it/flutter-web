import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:people_app/models/person.dart';

// https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
class PeopleService {
  Future<List<Person>> get people async {
    final response = await http.get(
      Uri.parse('https://servatedb.vercel.app/api/fudeo-flutter-web/all'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json as List)
          .map((item) => Person.fromJson(item))
          .toList(growable: false);
    }

    throw Error();
  }
}
