import 'package:dio/dio.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/config_images.dart';
import 'package:open_ai_simplified/domain/models/images_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

class OpenIARepository {
  OpenIARepository({
    OpenIAService? service,
  }) : _service = service ?? OpenIAService(Dio());

  // private that contains the apiKey of the user need to be initialized via addApiKey method
  String _apiKey = '';

  // contains a configCompletion object that have the information necessary to configure the
  // service of getting completions, default values are setted but you can change it with
  // the method configCompletionFromMap or configCompletionFromConfig
  ConfigCompletion _configCompletion = ConfigCompletion();

  // contains a ConfigEdits object that have the information necessary to configure the
  // service of getting edits, default values are setted but you can change it with
  // the method configEditsFromMap or configEditsFromConfig
  ConfigEdits _configEdits = ConfigEdits();

  // contains a ConfigImages object that have the information necessary to configure the
  // service of getting images, default values are setted but you can change it with
  // the method configImagesFromMap or configImagesFromConfig
  ConfigImages _configImages = ConfigImages();

  // this is the service that makes tha API calls
  OpenIAService get service => _service;
  final OpenIAService _service;

  // Add an APIKey to the package
  void addApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  // configure the images service from a map
  void configImagesFromMap(Map<String, dynamic> newConfig) {
    if (newConfig['n'] != null && (newConfig['n'] < 1 || newConfig['n'] > 10)) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    _configImages = _configImages.copyWith(
      n: newConfig['n'] ?? _configImages.n,
      size: newConfig['size'] ?? _configImages.size,
    );
  }

  // configure the images service from a ConfigImages object
  void configImagesFromConfig(ConfigImages newConfig) {
    if (newConfig.n < 1 || newConfig.n > 10) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    _configImages = _configImages.copyWith(
      n: newConfig.n,
      size: newConfig.size,
    );
  }

  // configure the completion service from a map
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

  // configure the completion service from a ConfigCompletion object
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

  // configure the edits service from a map
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

  // configure the edits service from a ConfigEdits object
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

  // get a Completion as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (prompt.isEmpty) {
        throw InvalidParamsException();
      }
      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response.toMap();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get a completion as CompletionResponse object
  Future<CompletionResponse> getCompletion(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (prompt.isEmpty) {
        throw InvalidParamsException();
      }
      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get a Models as Map<String, dynamic>
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

  // get the Models as OpenAiModels object
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

  // get a Edit as Map<String, dynamic>
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

  // get a Edit as EditsResponse object
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

  // get Images as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawImages(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (prompt.isEmpty) {
        throw InvalidParamsException();
      }
      final map = {'prompt': prompt};
      final result = await service.generateImages(
          apiKey: _apiKey, config: _configImages, prompt: map);
      return result.toMap();
    } catch (e) {
      if (e is OpenAIException) {
        rethrow;
      }
      throw Exception(e.toString());
    }
  }

  // get Images as ImagesResponse object
  Future<ImagesResponse> getImages(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        throw KeyNotFoundException();
      }
      if (prompt.isEmpty) {
        throw InvalidParamsException();
      }
      final map = {'prompt': prompt};
      final result = await service.generateImages(
          apiKey: _apiKey, config: _configImages, prompt: map);
      return result;
    } catch (e) {
      if (e is OpenAIException) {
        rethrow;
      }
      throw Exception(e.toString());
    }
  }
}
