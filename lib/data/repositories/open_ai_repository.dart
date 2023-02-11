import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/completion_response.dart';
import 'package:open_ai_simplified/domain/models/config_completion.dart';
import 'package:open_ai_simplified/domain/models/config_edits.dart';
import 'package:open_ai_simplified/domain/models/edits_response.dart';

class OpenIARepository {
  ConfigCompletion _configCompletion = ConfigCompletion();
  String _apiKey = '';
  ConfigEdits _configEdits = ConfigEdits();

  final OpenIAService service;
  OpenIARepository({
    required this.service,
  });

  void addApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  void configCompletionFromMap(Map<String, dynamic> newConfig) {
    _configCompletion = _configCompletion.copyWith(
        maxTokens: newConfig['max_token'],
        model: newConfig['model'],
        temperature: newConfig['temperature'],
        topP: newConfig['top_p'],
        n: newConfig['n'],
        stream: newConfig['stream'],
        logprobs: newConfig['logprobs'],
        stop: newConfig['stop']);
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
      n: newConfig['n'],
      temperature: newConfig['temperature'],
      topP: newConfig['top_p'],
    );
  }

  void configEditsFromConfig({
    required ConfigEdits config,
    required bool isText,
  }) {
    if (config.n != null && config.n! < 1) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    if (config.temperature != null &&
        (config.temperature! < 0 || config.temperature! < 2)) {
      throw InvalidParamsException(
          message: 'the temperature param is lower than 0 or higher than 2');
    }
    if (config.topP != null && config.topP! <= 0) {
      throw InvalidParamsException(message: 'the n param is lower than 0');
    }
    _configEdits = _configEdits.copyWith(
      isText: isText,
      n: config.n,
      temperature: config.temperature,
      topP: config.topP,
    );
  }

  Future<Map<String, dynamic>> getRawCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw Exception();
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
      final response = await service.getModelsLis(apiKey: _apiKey);
      return response.toMap();
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
