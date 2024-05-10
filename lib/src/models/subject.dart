class Subject {
  int? subjectId;
  String? name;

  Subject({this.subjectId, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['name'] = name;
    return data;
  }
}