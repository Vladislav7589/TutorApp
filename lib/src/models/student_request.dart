
class StudentRequest {
  final int subjectId;
  final int studentId;

  StudentRequest({
    required this.subjectId,
    required this.studentId,
  });

  factory StudentRequest.fromJson(Map<String, dynamic> json) {
    return StudentRequest(
      subjectId: json['subject_id_id'] as int,
      studentId: json['student_id_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id_id': subjectId,
      'student_id_id': studentId,
    };
  }
}