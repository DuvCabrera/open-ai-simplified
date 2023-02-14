// Exception type of the package
abstract class OpenAIException implements Exception {}

// throwed when apikey is not provided
class KeyNotFoundException extends OpenAIException {}

// throwed when some param is wrong
class InvalidParamsException extends OpenAIException {
  final String? message;

  InvalidParamsException({this.message = ""});
}
