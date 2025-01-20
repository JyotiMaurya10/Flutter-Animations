class Option {
  String description;
  bool isCorrect;

  Option({
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
