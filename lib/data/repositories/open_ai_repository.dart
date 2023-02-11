import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/completion_response.dart';
import 'package:open_ai_simplified/domain/models/config_ia.dart';

class OpenIARepository {
  Config _config = Config();
  String _apiKey = '';

  final OpenIAService service;
  OpenIARepository({
    required this.service,
  });

  void addApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  void reconfigFromMap(Map<String, dynamic> newConfig) {
    _config = _config.copyWith(
        maxTokens: newConfig['max_token'],
        model: newConfig['model'],
        temperature: newConfig['temperature'],
        topP: newConfig['top_p'],
        n: newConfig['n'],
        stream: newConfig['stream'],
        logprobs: newConfig['logprobs'],
        stop: newConfig['stop']);
  }

  void reconfigFromConfig(Config config) {
    _config = _config.copyWith(
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

  Future<Map<String, dynamic>> getRawCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw Exception();
      }
      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _config);
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
          prompt: prompt, apiKey: _apiKey, config: _config);
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
}
