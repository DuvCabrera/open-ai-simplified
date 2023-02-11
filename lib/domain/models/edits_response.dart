// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:open_ai_simplified/domain/models/usage.dart';

class EditsResponse {
  final String object;
  final int created;
  final List<ChoicesEdit> choices;
  final Usage usage;

  EditsResponse(this.object, this.created, this.choices, this.usage);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'created': created,
      'choices': choices.map((x) => x.toMap()).toList(),
      'usage': usage.toMap(),
    };
  }

  factory EditsResponse.fromMap(Map<String, dynamic> map) {
    return EditsResponse(
      map['object'] as String,
      map['created'] as int,
      List<ChoicesEdit>.from(
        (map['choices'] as List<int>).map<ChoicesEdit>(
          (x) => ChoicesEdit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      Usage.fromMap(map['usage'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory EditsResponse.fromJson(String source) =>
      EditsResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChoicesEdit {
  final String text;
  final int index;

  ChoicesEdit(this.text, this.index);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
    };
  }

  factory ChoicesEdit.fromMap(Map<String, dynamic> map) {
    return ChoicesEdit(
      map['text'] as String,
      map['index'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoicesEdit.fromJson(String source) =>
      ChoicesEdit.fromMap(json.decode(source) as Map<String, dynamic>);
}
