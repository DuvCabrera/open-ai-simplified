// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usage {
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promptTokens': promptTokens,
      'completionTokens': completionTokens,
      'totalTokens': totalTokens,
    };
  }

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      promptTokens:
          map['promptTokens'] != null ? map['promptTokens'] as int : null,
      completionTokens: map['completionTokens'] != null
          ? map['completionTokens'] as int
          : null,
      totalTokens:
          map['totalTokens'] != null ? map['totalTokens'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usage.fromJson(String source) =>
      Usage.fromMap(json.decode(source) as Map<String, dynamic>);
}
