
class User {
  final int id;
  final String? firstName, lastName, middleName, city;
  final String email;
  final bool isActive;
  final DateTime? dateJoined, dateOfBirth;

  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.city,
    required this.email,
    required this.isActive,
    this.dateJoined,
    this.dateOfBirth

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      middleName: json['middle_name'] ?? "",
      email: json['email'] as String,
      city: json['city'] ?? "",
      isActive: json['is_active'] as bool,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['email'] = email;
    data['city'] = city;
    data['isActive'] = isActive;
    data['dateJoined'] = dateJoined?.toIso8601String();
    data['date_of_birth'] = dateOfBirth?.toIso8601String();
    return data;
  }
}