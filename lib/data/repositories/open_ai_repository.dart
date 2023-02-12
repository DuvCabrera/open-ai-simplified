import 'package:dio/dio.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

class OpenIARepository {
  OpenIARepository({
    OpenIAService? service,
  }) : _service = service ?? OpenIAService(Dio());

  ConfigCompletion _configCompletion = ConfigCompletion();
  String _apiKey = '';
  ConfigEdits _configEdits = ConfigEdits();
  OpenIAService get service => _service;
  final OpenIAService _service;

  void addApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  void configCompletionFromMap(Map<String, dynamic> newConfig) {
    _configCompletion = _configCompletion.copyWith(
        maxTokens: newConfig['max_token'] ?? _configCompletion.maxTokens,
        model: newConfig['model'] ?? _configCompletion.model,
        temperature: newConfig['temperature'] ?? _configCompletion.temperature,
        topP: newConfig['top_p'] ?? _configCompletion.topP,
        n: newConfig['n'] ?? _configCompletion.n,
        stream: newConfig['stream'] ?? _configCompletion.stream,
        logprobs: newConfig['logprobs'] ?? _configCompletion.logprobs,
        stop: newConfig['stop'] ?? _configCompletion);
  }

  void configCompletionFromConfig(ConfigCompletion config) {
    _configCompletion = _configCompletion.copyWith(
      maxTokens: config.maxTokens,
      model: config.model,
      temperature: config.temperature,
      topP: config.topP,
      n: config.n,
      stream: config.stream,
      logprobs: config.logprobs,
      stop: config.stop,
    );
  }

  void configEditsFromMap({
    required Map<String, dynamic> newConfig,
    required bool isText,
  }) {
    if (newConfig['n'] != null && newConfig['n'] < 1) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    if (newConfig['temperature'] != null && newConfig['temperature'] < 0 ||
        newConfig['temperature'] < 2) {
      throw InvalidParamsException(
          message: 'the temperature param is lower than 0 or higher than 2');
    }
    if (newConfig['top_p'] != null && newConfig['top_p'] <= 0) {
      throw InvalidParamsException(message: 'the n param is lower than 0');
    }
    _configEdits = _configEdits.copyWith(
      isText: isText,
      n: newConfig['n'] ?? _configEdits.n,
      temperature: newConfig['temperature'] ?? _configEdits.temperature,
      topP: newConfig['top_p'] ?? _configEdits.topP,
    );
  }

  void configEditsFromConfig({
    required ConfigEdits config,
  }) {
    if (config.n != null && config.n! < 1) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    if (config.temperature != null &&
        (config.temperature! < 0 || config.temperature! > 2)) {
      throw InvalidParamsException(
          message: 'the temperature param is lower than 0 or higher than 2');
    }
    if (config.topP != null && config.topP! <= 0) {
      throw InvalidParamsException(message: 'the n param is lower than 0');
    }
    _configEdits = _configEdits.copyWith(
      isText: config.isText,
      n: config.n,
      temperature: config.temperature,
      topP: config.topP,
    );
  }

  Future<Map<String, dynamic>> getRawCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response.toMap();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CompletionResponse> getCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getRawModelsList() async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      final response = await service.getModelsList(apiKey: _apiKey);
      return response.toMap();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<OpenAiModels> getModelsList() async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      final response = await service.getModelsList(apiKey: _apiKey);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getRawEdits(
      {required String input, required String instruction}) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (input.isEmpty || instruction.isEmpty) {
        throw InvalidParamsException();
      }
      final map = {'input': input, 'instruction': instruction};
      final response = await service.getEdits(
          apiKey: _apiKey, config: _configEdits, inputWithInstruction: map);
      return response.toMap();
    } catch (e) {
      rethrow;
    }
  }

  Future<EditsResponse> getEdits(
      {required String input, required String instruction}) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (input.isEmpty || instruction.isEmpty) {
        throw InvalidParamsException();
      }
      final map = {'input': input, 'instruction': instruction};
      final response = await service.getEdits(
          apiKey: _apiKey, config: _configEdits, inputWithInstruction: map);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
