
class User {
  final int id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String email;
  final bool isActive;
  final DateTime dateJoined;

  User({
    required this.id,
    this.username,
    this.firstName,
    this.lastName,
    required this.email,
    required this.isActive,
    required this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      dateJoined: DateTime.parse(json['date_joined'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['isActive'] = isActive;
    data['dateJoined'] = dateJoined.toString();
    return data;
  }
}