
import 'package:tutor_app/src/models/review.dart';
import 'package:tutor_app/src/models/subject.dart';


// class TutorList {
//   final List<Tutor> tutorList;
//
//   TutorList(this.tutorList);
//
//   factory TutorList.fromListOfLists(List<List<dynamic>> data) {
//     final List<Tutor> tutors = data.map((list) => Tutor.fromList(list)).toList();
//     return TutorList(tutors);
//   }
// }

class TutorList {
  final List<Tutor?> tutorList;

  TutorList({
    required this.tutorList,
  });

  factory TutorList.fromJson(List<dynamic> json) {
    final List<dynamic> tutorList = json;

    return TutorList(
        tutorList: tutorList.map((tutorJson) => Tutor.fromJson(tutorJson)).toList()
    );
  }
}

class Tutor {
  final int? tutorId;
  final String? educationLevel, briefInfo, educationalInstitution, email, middleName, firstName, lastName, city, phone;
  final DateTime? dateOfBirth;
  final List<Subject>? subjects;
  final List<Review>? reviews;

  Tutor(
      {this.tutorId,
        this.educationLevel,
        this.briefInfo,
        this.educationalInstitution,
        this.email,
        this.middleName,
        this.firstName,
        this.lastName,
        this.city,
        this.dateOfBirth,
        this.phone,
        this.subjects,
        this.reviews});

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      tutorId: json['tutor_id'],
      educationLevel: json['education_level'],
      briefInfo: json['brief_info'],
      educationalInstitution: json['educational_institution'],
      email: json['email'],
      middleName: json['middle_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      city: json['city'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      subjects: (json['subjects'] as List<dynamic>)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorId;
    data['education_level'] = educationLevel;
    data['brief_info'] = briefInfo;
    data['educational_institution'] = educationalInstitution;
    data['email'] = email;
    data['middle_name'] = middleName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['city'] = city;
    data['date_of_birth'] = dateOfBirth;
    data['phone'] = phone;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
}