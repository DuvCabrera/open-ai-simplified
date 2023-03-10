class UrlBuilder {
  static const String _baseUrl = 'https://api.openai.com/v1/';
  static const String _completions = 'completions';
  static const String _models = 'models';
  static const String _edits = 'edits';
  static const String _images = 'images/';
  static const String _generations = 'generations';
  static const String _variations = 'variations';
  static const String _embeddings = 'embeddings';
  static const String _files = 'files';
  static const String _content = 'content';
  static const String _moderations = 'moderations';
  static const String _fineTunes = 'fine-tunes';
  static const String _cancel = 'cancel';

  static const String completionsPath = _baseUrl + _completions;
  static const String modelsPath = _baseUrl + _models;
  static const String editsPath = _baseUrl + _edits;
  static const String imagesGenerationsPath = _baseUrl + _images + _generations;
  static const String imagesVariationsPath = _baseUrl + _images + _variations;
  static const String imagesEditsPath = _baseUrl + _images + _edits;
  static const String embeddingsPath = _baseUrl + _embeddings;
  static const String filesPath = _baseUrl + _files;
  static const String moderationsPath = _baseUrl + _moderations;
  static const String fineTunesPath = _baseUrl + _fineTunes;
  static String filePathWithId(String fileId) => '$filesPath/$fileId';
  static String filePathWithIdNContent(String fileId) =>
      '$filesPath/$fileId/$_content';
  static String fineTunesPathWithId(String fineTuneId) =>
      '$fineTunesPath/$fineTuneId';
  static String fineTunesPathWithIdNCancel(String fineTuneId) =>
      '$fineTunesPath/$fineTuneId/$_cancel';
  static String fineTunesDeletePathWithIdModel(String model) =>
      '$modelsPath/$model';
}
