class UrlBuilder {
  static const String _baseUrl = 'https://api.openai.com/v1/';
  static const String _completions = 'completions';
  static const String _models = 'models';

  static const String completionsPath = _baseUrl + _completions;
  static const String modelsPath = _baseUrl + _models;
}
