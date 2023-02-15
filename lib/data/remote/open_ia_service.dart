import 'dart:io';

import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import 'package:open_ai_simplified/data/infraestructure/url_builder.dart';
import 'package:open_ai_simplified/domain/models/config_images.dart';
import 'package:open_ai_simplified/domain/models/images_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

class OpenIAService {
  final Dio dio;

  OpenIAService(this.dio);
  // Generate and delivery a Completion via post
  Future<CompletionResponse> getCompletion({
    required String prompt,
    required String apiKey,
    required ConfigCompletion config,
  }) async {
    try {
      final map = config.toMap();
      map.addAll({'prompt': prompt});
      final response = await dio.post(UrlBuilder.completionsPath,
          data: map,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          }));

      return CompletionResponse.fromMap(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get the models availables to use on the configs via get
  Future<OpenAiModels> getModelsList({
    required String apiKey,
  }) async {
    try {
      final response = await dio.get(UrlBuilder.modelsPath,
          options: Options(headers: {'Authorization': 'Bearer $apiKey'}));
      return OpenAiModels.fromMap(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Generate and delivery a Edits via post
  Future<EditsResponse> getEdits(
      {required String apiKey,
      required ConfigEdits config,
      required Map<String, dynamic> inputWithInstruction}) async {
    try {
      final map = config.toMap();
      map.addAll(inputWithInstruction);
      final response = await dio.post(UrlBuilder.editsPath,
          data: map,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          }));
      return EditsResponse.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Generate and delivery Images via post
  Future<ImagesResponse> generateImages(
      {required String apiKey,
      required ConfigImages config,
      required Map<String, dynamic> prompt}) async {
    final map = config.toMap();
    map.addAll(prompt);
    final response = await dio.post(UrlBuilder.imagesGenerationsPath,
        data: map,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        }));

    return ImagesResponse.fromMap(response.data);
  }

  // Delivery a variation of an image provided
  Future<ImagesResponse> variateImage({
    required File image,
    required String apiKey,
    required ConfigImages config,
  }) async {
    final Map<String, dynamic> map = {
      'image': await MultipartFile.fromFile(
        image.path,
        filename: 'image',
        contentType: MediaType('image', 'png'),
      )
    };
    map.addAll(config.toMap());
    final formData = FormData.fromMap(map);

    final response = await dio.post(UrlBuilder.imagesVariationsPath,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multpart/form-data',
          'Authorization': 'Bearer $apiKey'
        }));

    return ImagesResponse.fromMap(response.data);
  }
}
