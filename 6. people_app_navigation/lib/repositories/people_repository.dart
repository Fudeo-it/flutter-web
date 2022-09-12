import 'package:people_app/models/person.dart';
import 'package:people_app/services/people_service.dart';

class PeopleRepository {
  final PeopleService peopleService;

  PeopleRepository({required this.peopleService});

  Future<List<Person>> get people => peopleService.people;
}
