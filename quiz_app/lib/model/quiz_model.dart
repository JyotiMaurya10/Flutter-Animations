import 'package:quiz_app/model/question_model.dart';

class Quiz {
  String title;
  String topic;
  double negativeMarks;
  double correctAnswerMarks;
  String dailyDate;
  List<Question> questions;

  Quiz({
    required this.title,
    required this.topic,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.dailyDate,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'] ?? '',
      topic: json['topic'] ?? '',
      negativeMarks: double.parse(json['negative_marks'] ?? '0'),
      correctAnswerMarks: double.parse(json['correct_answer_marks'] ?? '0'),
      dailyDate: json['daily_date'] ?? '',
      questions: (json['questions'] as List<dynamic>).map((question) => Question.fromJson(question)).toList(),
    );
  }
}
