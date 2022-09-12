import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pexels_app/models/photo.dart';

// https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
class PexelsService {
  Future<List<Photo>> search(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=50&orientation=landscape'),
      headers: {
        'Authorization':
            '<token>',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json['photos'] as List)
          .map((item) => Photo.fromJson(item))
          .toList(growable: false);
    }

    throw Error();
  }

  Future<Photo> photo(int id) async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/photos/$id'),
      headers: {
        'Authorization':
            '<token>',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Photo.fromJson(json);
    }

    throw Error();
  }
}
