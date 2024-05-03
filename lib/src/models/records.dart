class RecordList {
  List<Record> recordList;

  RecordList({required this.recordList});

  factory RecordList.fromJsonList(List<dynamic> jsonList) {
    List<Record> records = jsonList.map((json) => Record.fromJson(json)).toList();
    return RecordList(recordList: records);
  }

  List<Map<String, dynamic>> toJsonList() {
    return recordList.map((record) => record.toJson()).toList();
  }
}

class Record {
  final int lessonId;
  final int studentId;

  Record({
    required this.lessonId,
    required this.studentId,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      lessonId: json['lesson_id'] as int,
      studentId: json['student_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lesson_id': lessonId,
      'student_id': studentId,
    };
  }
}