import 'package:faker/faker.dart';

class Email {
  final int id;
  final String firstName;
  final String lastName;
  final String subject;
  final String body;

  Email(
    this.id, {
    required this.firstName,
    required this.lastName,
    required this.subject,
    required this.body,
  });

  String get initials =>
      [firstName, lastName].map((word) => word.substring(0, 1)).join();

  String get fullName => [firstName, lastName].join(' ');

  static List<Email> emails([int length = 30]) {
    final faker = Faker();

    return List.generate(
      length,
      (id) => Email(
        id,
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        subject: faker.job.title(),
        body: faker.lorem.sentences(30).join('\n'),
      ),
    );
  }
}
