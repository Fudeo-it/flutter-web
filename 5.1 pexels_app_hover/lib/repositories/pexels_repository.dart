import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/services/pexels_service.dart';

class PexelsRepository {
  final PexelsService pexelsService;

  PexelsRepository({required this.pexelsService});

  Future<List<Photo>> search(String query) => pexelsService.search(query);
}
