class ConfigCompletion {
  // model utilized to create the completion
  final String? model;
  // Max Number of the Token disired to be spend in the request
  final int? maxTokens;
  //What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  final double? temperature;
  // An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  // We generally recommend altering this or temperature but not both.
  final int? topP;
  // How many completions to generate for each prompt.
  // Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
  final int? n;
  // Whether to stream back partial progress. If set, tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a data: [DONE] message.
  final bool? stream;
  // Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response.
  // The maximum value for logprobs is 5. If you need m
  final int? logprobs;
  // Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
  final String? stop;

  ConfigCompletion(
      {this.model = "text-davinci-003",
      this.maxTokens = 150,
      this.temperature = 0.9,
      this.topP = 1,
      this.n = 1,
      this.stream = false,
      this.logprobs,
      this.stop = ""});

  // Generate a new ConfigCompletion object from the original object
  ConfigCompletion copyWith({
    String? model,
    int? maxTokens,
    double? temperature,
    int? topP,
    int? n,
    bool? stream,
    int? logprobs,
    String? stop,
  }) {
    return ConfigCompletion(
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

  // Converts the object to a Map<String, dynamic>
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

  // Create the object from a Map<String, dynamic>
  factory ConfigCompletion.fromMap(Map<String, dynamic> map) {
    return ConfigCompletion(
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
}
