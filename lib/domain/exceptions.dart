abstract class OpenAIException implements Exception {}

class KeyNotFoundException extends OpenAIException {}

class InvalidParamsException extends OpenAIException {
  final String? message;

  InvalidParamsException({this.message = ""});
}
