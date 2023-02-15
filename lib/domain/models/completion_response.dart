import 'package:open_ai_simplified/domain/models/usage.dart';

class CompletionResponse {
  // id of the object
  final String id;
  // type of the object
  final String object;
  // date of the moment were the object was created
  final int created;
  // model utilized to create the completion
  final String model;
  // list of the values that brings the completion
  final List<Choices> choices;
  // object that shows how much Tokens were spended on the request + response
  final Usage usage;

  CompletionResponse(
      {required this.id,
      required this.object,
      required this.created,
      required this.model,
      required this.choices,
      required this.usage});

  // Converts the object to a Map<String, dynamic>
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

  // Create the object from a Map<String, dynamic>
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
}

class Choices {
  // Text requested
  final String text;
  // Index of the present text on the list
  final int index;
  // Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response.
  final int? logprobs;
  // In case of the response need to stop, here will be the awnser to why it stop.
  final String finishReason;

  Choices({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  // Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
      'logprobs': logprobs,
      'finish_reason': finishReason,
    };
  }

  // Create the object from a Map<String, dynamic>
  factory Choices.fromMap(Map<String, dynamic> map) {
    return Choices(
      text: map['text'] as String,
      index: map['index'] as int,
      logprobs: map['logprobs'] != null ? map['logprobs'] as int : null,
      finishReason: map['finish_reason'] as String,
    );
  }
}
