
class User {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String email;
  final String? city;
  final bool isActive;
  final DateTime dateJoined;

  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.city,
    required this.email,
    required this.isActive,
    required this.dateJoined,
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
      dateJoined: DateTime.parse(json['date_joined'] as String),
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
    data['dateJoined'] = dateJoined.toString();
    return data;
  }
}