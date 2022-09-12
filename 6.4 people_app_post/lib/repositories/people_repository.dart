import 'package:people_app/models/person.dart';
import 'package:people_app/services/people_service.dart';

class PeopleRepository {
  final PeopleService peopleService;

  PeopleRepository({required this.peopleService});

  Future<List<Person>> get people => peopleService.people;

  Future<Person> save({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String address,
    required String city,
    required String state,
  }) {
    final personToSave = Person(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      address: address,
      city: city,
      state: state,
    );

    return peopleService.save(personToSave);
  }
}
