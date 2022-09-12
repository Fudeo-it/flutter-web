class Person {
  final String? id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String address;
  final String city;
  final String state;

  Person({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
    required this.city,
    required this.state,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthDate: DateTime.fromMillisecondsSinceEpoch(json['birthDate']),
        address: json['address'],
        city: json['city'],
        state: json['state'],
      );
}
