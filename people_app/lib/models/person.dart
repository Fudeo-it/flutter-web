import 'package:faker/faker.dart';

class Person {
  final int id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String address;
  final String city;
  final String state;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
    required this.city,
    required this.state,
  });

  static List<Person>? _persons;

  static List<Person> persons([int length = 30]) {
    final faker = Faker();

    return _persons ??= List.generate(
        length,
        (id) => Person(
              id: id + 1,
              firstName: faker.person.firstName(),
              lastName: faker.person.lastName(),
              birthDate: faker.date.dateTime(),
              address: faker.address.streetAddress(),
              city: faker.address.city(),
              state: faker.address.state(),
            ));
  }
}
