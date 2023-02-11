import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Config {
  final String? model;
  final int? maxTokens;
  final double? temperature;
  final int? topP;
  final int? n;
  final bool? stream;
  final int? logprobs;
  final String? stop;

  Config(
      {this.model = "text-davinci-003",
      this.maxTokens = 256,
      this.temperature = 0.6,
      this.topP = 1,
      this.n = 1,
      this.stream = false,
      this.logprobs,
      this.stop = "\n"});

  Config copyWith({
    String? model,
    int? maxTokens,
    double? temperature,
    int? topP,
    int? n,
    bool? stream,
    int? logprobs,
    String? stop,
  }) {
    return Config(
      model: model ?? this.model,
      maxTokens: maxTokens ?? this.maxTokens,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      n: n ?? this.n,
      stream: stream ?? this.stream,
      logprobs: logprobs ?? this.logprobs,
      stop: stop ?? this.stop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'max_tokens': maxTokens,
      'temperature': temperature,
      'top_p': topP,
      'n': n,
      'stream': stream,
      'logprobs': logprobs,
      'stop': stop,
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      model: map['model'] != null ? map['model'] as String : null,
      maxTokens: map['max_tokens'] != null ? map['max_tokens'] as int : null,
      temperature:
          map['temperature'] != null ? map['temperature'] as double : null,
      topP: map['top_p'] != null ? map['top_p'] as int : null,
      n: map['n'] != null ? map['n'] as int : null,
      stream: map['stream'] != null ? map['stream'] as bool : null,
      logprobs: map['logprobs'] != null ? map['logprobs'] as int : null,
      stop: map['stop'] != null ? map['stop'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Config.fromJson(String source) =>
      Config.fromMap(json.decode(source) as Map<String, dynamic>);
}
