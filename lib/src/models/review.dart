
class Review {
  int? studentId, rating;
  String? dateAndTime, feedback;

  Review({this.studentId, this.dateAndTime, this.rating, this.feedback});

  Review.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    dateAndTime = json['date_and_time'];
    rating = json['rating'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['date_and_time'] = dateAndTime;
    data['rating'] = rating;
    data['feedback'] = feedback;
    return data;
  }
}