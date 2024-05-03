class TutorSubject {
  final int tutorId;
  final int subjectId;

  TutorSubject({
    required this.tutorId,
    required this.subjectId,
  });

  factory TutorSubject.fromJson(Map<String, dynamic> json) {
    return TutorSubject(
      tutorId: json['tutor_id_id'] as int,
      subjectId: json['subject_id_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tutor_id_id': tutorId,
      'subject_id_id': subjectId,
    };
  }
}