import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/embeddings_response.dart';
import 'package:open_ai_simplified/domain/models/list_file_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';
import 'package:open_ai_simplified/domain/models/moderation_response.dart';

class OpenIARepository {
  OpenIARepository({
    OpenIAService? service,
  }) : _service = service ?? OpenIAService(Dio());

  /// private that contains the apiKey of the user need to be initialized via addApiKey method
  String _apiKey = '';

  /// contains a configCompletion object that have the information necessary to configure the
  /// service of getting completions, default values are setted but you can change it with
  /// the method configCompletionFromMap or configCompletionFromConfig
  ConfigCompletion _configCompletion = ConfigCompletion();

  /// contains a ConfigEdits object that have the information necessary to configure the
  /// service of getting edits, default values are setted but you can change it with
  /// the method configEditsFromMap or configEditsFromConfig
  ConfigEdits _configEdits = ConfigEdits();

  /// contains a ConfigImages object that have the information necessary to configure the
  /// service of getting images, default values are setted but you can change it with
  /// the method configImagesFromMap or configImagesFromConfig
  ConfigImages _configImages = ConfigImages();

  /// contains a ConfigEmbedding object that have the information necessary to configure the
  /// service of getting embeddings, default values are setted but you can change it with
  /// the method configEmbeddingFromMap or configEmbeddingFromConfig
  ConfigEmbedding _configEmbedding = ConfigEmbedding();

  /// this is the service that makes tha API calls
  OpenIAService get service => _service;
  final OpenIAService _service;

  /// Add an APIKey to the package
  void addApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  /// configure Embedding service from map
  void configEmbeddingFromMap(Map<String, dynamic> newConfig) {
    if (newConfig.isEmpty) {
      throw InvalidParamsException(
          message: 'newConfig should have data inside');
    }
    _configEmbedding =
        ConfigEmbedding(model: newConfig['model'] ?? _configEmbedding.model);
  }

  /// configure Embedding service from map
  void configEmbeddingConfig(ConfigEmbedding newConfig) {
    _configEmbedding = ConfigEmbedding(model: newConfig.model);
  }

  /// configure the images service from a map
  void configImagesFromMap(Map<String, dynamic> newConfig) {
    if (newConfig['n'] != null && (newConfig['n'] < 1 || newConfig['n'] > 10)) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    if (newConfig['size'] != '256x256' ||
        newConfig['size'] != '512x512' ||
        newConfig['size'] != '1024x1024') {
      throw InvalidParamsException(
          message:
              'the size param must be ne of 256x256, 512x512, or 1024x1024');
    }
    _configImages = _configImages.copyWith(
      n: newConfig['n'] ?? _configImages.n,
      size: newConfig['size'] ?? _configImages.size,
    );
  }

  /// configure the images service from a ConfigImages object
  void configImagesFromConfig(ConfigImages newConfig) {
    if (newConfig.n < 1 || newConfig.n > 10) {
      throw InvalidParamsException(message: 'the n param is lower than 1');
    }
    if (newConfig.size != '256x256' &&
        newConfig.size != '512x512' &&
        newConfig.size != '1024x1024') {
      throw InvalidParamsException(
          message:
              'the size param must be ne of 256x256, 512x512, or 1024x1024');
    }
    _configImages = _configImages.copyWith(
      n: newConfig.n,
      size: newConfig.size,
    );
  }

  /// configure the completion service from a map
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

  /// configure the completion service from a ConfigCompletion object
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

  /// configure the edits service from a map
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

  /// configure the edits service from a ConfigEdits object
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

  /// get a Completion as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawCompletion(String prompt) async {
    try {
      _checkApi(values: [prompt]);

      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get a completion as CompletionResponse object
  Future<CompletionResponse> getCompletion(String prompt) async {
    try {
      _checkApi(values: [prompt]);

      final response = await service.getCompletion(
          prompt: prompt, apiKey: _apiKey, config: _configCompletion);
      return response;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get a Models as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawModelsList() async {
    try {
      _checkApi();
      final response = await service.getModelsList(apiKey: _apiKey);
      return response.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get the Models as OpenAiModels object
  Future<OpenAiModels> getModelsList() async {
    try {
      _checkApi();
      final response = await service.getModelsList(apiKey: _apiKey);
      return response;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get a Edit as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawEdits(
      {required String input, required String instruction}) async {
    try {
      _checkApi(values: [input, instruction]);

      final map = {'input': input, 'instruction': instruction};
      final response = await service.getEdits(
          apiKey: _apiKey, config: _configEdits, inputWithInstruction: map);
      return response.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get a Edit as EditsResponse object
  Future<EditsResponse> getEdits(
      {required String input, required String instruction}) async {
    try {
      _checkApi(values: [input, instruction]);

      final map = {'input': input, 'instruction': instruction};
      final response = await service.getEdits(
          apiKey: _apiKey, config: _configEdits, inputWithInstruction: map);
      return response;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get Images as Map<String, dynamic>
  Future<Map<String, dynamic>> getRawImages(String prompt) async {
    try {
      _checkApi(values: [prompt]);

      final map = {'prompt': prompt};
      final result = await service.generateImages(
          apiKey: _apiKey, config: _configImages, prompt: map);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// get Images as ImagesResponse object
  Future<ImagesResponse> getImages(String prompt) async {
    try {
      _checkApi(values: [prompt]);

      final map = {'prompt': prompt};
      final result = await service.generateImages(
          apiKey: _apiKey, config: _configImages, prompt: map);
      return result;
    } catch (e) {
      if (e is OpenAIException) {
        rethrow;
      } else {
        throw Exception(e.toString());
      }
    }
  }

  /// create a variation of an image and return as ImagesResponse object
  Future<ImagesResponse> createAImageVariation(
      {required File imageFile}) async {
    try {
      _checkApi();

      final result = await service.variateImage(
          image: imageFile, apiKey: _apiKey, config: _configImages);
      return result;
    } catch (e) {
      if (e is OpenAIException) {
        rethrow;
      } else {
        throw Exception(e.toString());
      }
    }
  }

  /// create a variation of an image and return as a Map
  Future<Map<String, dynamic>> createRawImageVariation(
      {required File imageFile}) async {
    try {
      _checkApi();

      final result = await service.variateImage(
          image: imageFile, apiKey: _apiKey, config: _configImages);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Creates an edited or extended image given an original image and a prompt.
  /// Provide a mask is optional
  /// An mask is: An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
  /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
  Future<ImagesResponse> editImage({
    required File image,
    File? mask,
    required String prompt,
  }) async {
    try {
      _checkApi(values: [prompt]);

      final result = await service.editImage(
          prompt: prompt,
          image: image,
          apiKey: _apiKey,
          config: _configImages,
          mask: mask);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Creates an edited or extended image given an original image and a prompt.
  /// Provide a mask is optional
  /// An mask is: An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
  Future<Map<String, dynamic>> editRawImage({
    required File image,
    File? mask,
    required String prompt,
  }) async {
    try {
      _checkApi(values: [prompt]);

      final result = await service.editImage(
          prompt: prompt, image: image, apiKey: _apiKey, config: _configImages);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Creates an embedding vector representing the input text. returns it in Map
  Future<Map<String, dynamic>> createRawEmbedding(
      {required String prompt}) async {
    try {
      _checkApi(values: [prompt]);

      final map = {'model': _configEmbedding.model, 'input': prompt};
      final result =
          await service.createEmbedding(apiKey: _apiKey, promptWithModel: map);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Creates an embedding vector representing the input text. returns it as a EmbeddingsResponse object
  Future<EmbeddingsResponse> createEmbedding({required String prompt}) async {
    try {
      _checkApi(values: [prompt]);
      final map = {'model': _configEmbedding.model, 'input': prompt};
      final result =
          await service.createEmbedding(apiKey: _apiKey, promptWithModel: map);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Retrives the list of stored files as ListFileResponse object.
  Future<ListFileResponse> getFilesList() async {
    try {
      _checkApi();
      final result = await service.getFileList(apiKey: _apiKey);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Retrives the list of stored files as Map.
  Future<Map<String, dynamic>> getRawFilesList() async {
    try {
      _checkApi();
      final result = await service.getFileList(apiKey: _apiKey);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Upload an file with some purpouse ex: fine-tune, search.
  Future<FileData> uploadFile(
      {required File file, required String purpose}) async {
    try {
      _checkApi(values: [purpose]);
      final result = await service.uploadFile(
          apiKey: _apiKey, file: file, purpose: purpose);

      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Upload an file with some purpouse ex: fine-tune, search. returns a Map
  Future<Map<String, dynamic>> uploadFileReturningAMap(
      {required File file, required String purpose}) async {
    try {
      _checkApi(values: [purpose]);
      final result = await service.uploadFile(
          apiKey: _apiKey, file: file, purpose: purpose);

      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Delete a file
  Future<Map<String, dynamic>> deleteFile({required String fileId}) async {
    try {
      _checkApi(values: [fileId]);
      final result = await service.deleteFile(fileId: fileId, apiKey: _apiKey);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Returns information about a specific file as FileData
  Future<FileData> retriveFileInfo({required String fileId}) async {
    try {
      _checkApi(values: [fileId]);
      final result = await service.retriveFile(fileId: fileId, apiKey: _apiKey);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Returns information about a specific file as Map
  Future<Map<String, dynamic>> retriveRawFileInfo(
      {required String fileId}) async {
    try {
      _checkApi(values: [fileId]);
      final result = await service.retriveFile(fileId: fileId, apiKey: _apiKey);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Returns the contents of the specified file.
  Future<File> retriveFileContent({required String fileId}) async {
    try {
      _checkApi(values: [fileId]);
      final result =
          await service.retriveFileContent(fileId: fileId, apiKey: _apiKey);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Classifies if text violates OpenAI's Content Policy, returns ModerationResponse object
  Future<ModerationResponse> moderationCheck({required String input}) async {
    try {
      _checkApi(values: [input]);
      final map = {'input': input};
      final result = await service.checkModeration(input: map, apiKey: _apiKey);
      return result;
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// Classifies if text violates OpenAI's Content Policy, returns a Map
  Future<Map<String, dynamic>> rawModerationCheck(
      {required String input}) async {
    try {
      _checkApi(values: [input]);
      final map = {'input': input};
      final result = await service.checkModeration(input: map, apiKey: _apiKey);
      return result.toMap();
    } catch (e) {
      throw _exceptionCheck(e);
    }
  }

  /// check if the error is an OpenAiException then throw
  _exceptionCheck(Object e) {
    if (e is OpenAIException) {
      throw e;
    } else {
      throw Exception(e.toString());
    }
  }

  /// checks if the prerequisites are valid
  void _checkApi({List<String>? values}) {
    if (_apiKey.isEmpty) {
      throw KeyNotFoundException();
    }
    if (values != null) {
      for (var item in values) {
        if (item.isEmpty) {
          throw InvalidParamsException();
        }
      }
    }
  }
}
