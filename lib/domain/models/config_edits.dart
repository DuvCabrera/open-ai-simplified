import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConfigEdits {
  final bool isText;
  String get model => getModel();
  final int? n;
  final double? temperature;
  final int? topP;

  String getModel() {
    if (isText) {
      return 'text-davinci-edit-001';
    } else {
      return 'code-davinci-edit-001';
    }
  }

  ConfigEdits(
      {this.isText = true, this.n = 1, this.temperature = 1, this.topP = 1});

  ConfigEdits copyWith({
    bool? isText,
    int? n,
    double? temperature,
    int? topP,
  }) {
    return ConfigEdits(
      isText: isText ?? this.isText,
      n: n ?? this.n,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'n': n,
      'temperature': temperature,
      'top_p': topP,
    };
  }

  factory ConfigEdits.fromMap(Map<String, dynamic> map) {
    return ConfigEdits(
      isText: map['isText'] as bool,
      n: map['n'] != null ? map['n'] as int : null,
      temperature:
          map['temperature'] != null ? map['temperature'] as double : null,
      topP: map['top_p'] != null ? map['topP'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigEdits.fromJson(String source) =>
      ConfigEdits.fromMap(json.decode(source) as Map<String, dynamic>);
}
