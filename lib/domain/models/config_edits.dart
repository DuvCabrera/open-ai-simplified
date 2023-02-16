class ConfigEdits {
  /// the APi provide Edits to code or to text, this field help us to chose the right model
  final bool isText;

  /// Give the right model based on the field isText, the model is used to config the api
  String get model => getModel();

  /// How many completions to generate for each prompt.
  final int? n;

  /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  final double? temperature;

  /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  final int? topP;

  /// returns a model based on the field isText
  String getModel() {
    if (isText) {
      return 'text-davinci-edit-001';
    } else {
      return 'code-davinci-edit-001';
    }
  }

  ConfigEdits(
      {this.isText = true, this.n = 1, this.temperature = 1, this.topP = 1});

  /// Generate a new ConfigEdits object from the original object.
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

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'n': n,
      'temperature': temperature,
      'top_p': topP,
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory ConfigEdits.fromMap(Map<String, dynamic> map) {
    return ConfigEdits(
      isText: map['isText'] as bool,
      n: map['n'] != null ? map['n'] as int : null,
      temperature:
          map['temperature'] != null ? map['temperature'] as double : null,
      topP: map['top_p'] != null ? map['topP'] as int : null,
    );
  }
}
