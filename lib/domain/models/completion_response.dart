// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:open_ai_simplified/domain/models/usage.dart';

class CompletionResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choices> choices;
  final Usage usage;

  CompletionResponse(
      {required this.id,
      required this.object,
      required this.created,
      required this.model,
      required this.choices,
      required this.usage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'choices': choices.map((x) => x.toMap()).toList(),
      'usage': usage.toMap(),
    };
  }

  factory CompletionResponse.fromMap(Map<String, dynamic> map) {
    return CompletionResponse(
      id: map['id'] as String,
      object: map['object'] as String,
      created: map['created'] as int,
      model: map['model'] as String,
      choices: List<Choices>.from(
        (map['choices'] as List<dynamic>).map<Choices>(
          (x) => Choices.fromMap(x as Map<String, dynamic>),
        ),
      ),
      usage: Usage.fromMap(map['usage'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompletionResponse.fromJson(String source) =>
      CompletionResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Choices {
  final String text;
  final int index;
  final int? logprobs;
  final String finishReason;

  Choices({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
      'logprobs': logprobs,
      'finish_reason': finishReason,
    };
  }

  factory Choices.fromMap(Map<String, dynamic> map) {
    return Choices(
      text: map['text'] as String,
      index: map['index'] as int,
      logprobs: map['logprobs'] != null ? map['logprobs'] as int : null,
      finishReason: map['finish_reason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Choices.fromJson(String source) =>
      Choices.fromMap(json.decode(source) as Map<String, dynamic>);
}
