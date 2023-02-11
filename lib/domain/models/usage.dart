import 'dart:convert';

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
      'total_tokens': totalTokens,
    };
  }

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      promptTokens: map['prompt_tokens'] as int,
      completionTokens: map['completion_tokens'] as int,
      totalTokens: map['total_tokens'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usage.fromJson(String source) =>
      Usage.fromMap(json.decode(source) as Map<String, dynamic>);
}
