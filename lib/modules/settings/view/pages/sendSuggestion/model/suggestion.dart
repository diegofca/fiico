class Suggestion {
  final String id;
  final String text;
  final SuggestionType type;

  Suggestion({
    this.id = '',
    required this.text,
    required this.type,
  });

  factory Suggestion.fromJson(Map<String, dynamic>? json) {
    return Suggestion(
      id: json?['id'],
      text: json?['text'],
      type: SuggestionType.values.firstWhere((e) => e.name == json?['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
    };
  }
}

enum SuggestionType { suggestion, removeAccount }
