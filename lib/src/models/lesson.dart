import 'package:flutter/material.dart';

class Lesson {
  final int lessonId;
  final int tutorId;
  final int subjectId;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String status;

  Lesson({
    required this.lessonId,
    required this.tutorId,
    required this.subjectId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lesson_id'] as int,
      tutorId: json['tutor_id'] as int,
      subjectId: json['subject_id'] as int,
      date: DateTime.parse(json['date'] as String),
      startTime: TimeOfDay.fromDateTime(DateTime.parse(json['start_time'] as String)),
      endTime: TimeOfDay.fromDateTime(DateTime.parse(json['end_time'] as String)),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lesson_id': lessonId,
      'tutor_id': tutorId,
      'subject_id': subjectId,
      'date': date.toIso8601String(),
      'start_time': '${startTime.hour}:${startTime.minute}',
      'end_time': '${endTime.hour}:${endTime.minute}',
      'status': status,
    };
  }
}