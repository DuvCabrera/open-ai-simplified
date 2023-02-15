class UrlBuilder {
  static const String _baseUrl = 'https://api.openai.com/v1/';
  static const String _completions = 'completions';
  static const String _models = 'models';
  static const String _edits = 'edits';
  static const String _images = 'images/';
  static const String _generations = 'generations';
  static const String _variations = 'variations';

  static const String completionsPath = _baseUrl + _completions;
  static const String modelsPath = _baseUrl + _models;
  static const String editsPath = _baseUrl + _edits;
  static const String imagesGenerationsPath = _baseUrl + _images + _generations;
  static const String imagesVariationsPath = _baseUrl + _images + _variations;
}
