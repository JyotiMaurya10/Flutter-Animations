import 'package:quiz_app/model/option.dart';

class Question {
  String description;
  String detailedSolution;
  List<Option> options;

  Question({
    required this.description,
    required this.detailedSolution,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      description: json['description'] ?? '',
      detailedSolution: json['detailed_solution'] ?? '',
      options: (json['options'] as List<dynamic>).map((option) => Option.fromJson(option)).toList(),
    );
  }
}
