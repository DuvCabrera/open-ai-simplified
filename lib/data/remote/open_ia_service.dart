import 'dart:io';

import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import 'package:open_ai_simplified/data/infraestructure/url_builder.dart';
import 'package:open_ai_simplified/domain/models/embeddings_response.dart';
import 'package:open_ai_simplified/domain/models/list_file_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';
import 'package:path_provider/path_provider.dart';

class OpenIAService {
  final Dio dio;

  OpenIAService(this.dio);

  /// Generate and delivery a Completion via post
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

  /// Get the models availables to use on the configs via get
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

  /// Generate and delivery a Edits via post
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

  /// Generate and delivery Images via post
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

  /// Delivery a variation of an image provided
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

  /// Delivery an image from another image
  Future<ImagesResponse> editImage({
    required String prompt,
    required File image,
    File? mask,
    required String apiKey,
    required ConfigImages config,
  }) async {
    final Map<String, dynamic> map = {
      'image': await MultipartFile.fromFile(
        image.path,
        filename: 'image',
        contentType: MediaType('image', 'png'),
      ),
      "prompt": prompt,
    };
    if (mask != null) {
      final maskMap = {
        'mask': await MultipartFile.fromFile(
          mask.path,
          filename: 'image',
          contentType: MediaType('image', 'png'),
        ),
      };
      map.addAll(maskMap);
    }
    map.addAll(config.toMap());
    final formData = FormData.fromMap(map);

    final response = await dio.post(UrlBuilder.imagesEditsPath,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multpart/form-data',
          'Authorization': 'Bearer $apiKey'
        }));

    return ImagesResponse.fromMap(response.data);
  }

  /// Create Embeddings
  Future<EmbeddingsResponse> createEmbedding(
      {required String apiKey,
      required Map<String, dynamic> promptWithModel}) async {
    final response = await dio.post(UrlBuilder.embeddingsPath,
        data: promptWithModel,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        }));
    return EmbeddingsResponse.fromMap(response.data);
  }

  /// Retrives the list of stored files
  Future<ListFileResponse> getFileList({required String apiKey}) async {
    final response = await dio.get(UrlBuilder.filesPath,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}));
    return ListFileResponse.fromMap(response.data);
  }

  /// Upload a file that contains document(s) to be used across various endpoints/features.
  /// Currently, the size of all the files uploaded by one organization can be up to 1 GB.
  Future<FileData> uploadFile(
      {required String apiKey,
      required File file,
      required String purpose}) async {
    final formData = FormData.fromMap({
      'purpose': purpose,
      'file': await MultipartFile.fromFile(file.path),
    });
    final response = await dio.post(UrlBuilder.filesPath,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multpart/form-data',
          'Authorization': 'Bearer $apiKey'
        }));

    return FileData.fromMap(response.data);
  }

  /// Delete a file.
  Future<Map<String, dynamic>> deleteFile(
      {required String fileId, required String apiKey}) async {
    final response = await dio.delete(UrlBuilder.filePathWithId(fileId),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        }));
    return response.data;
  }

  /// Returns information about a specific file.
  Future<FileData> retriveFile(
      {required String fileId, required String apiKey}) async {
    final response = await dio.get(UrlBuilder.filePathWithId(fileId),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        }));

    return FileData.fromMap(response.data);
  }

  /// Returns the contents of the specified file.
  Future<File> retriveFileContent(
      {required String fileId, required String apiKey}) async {
    final response = await dio.get(UrlBuilder.filePathWithIdNContent(fileId),
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}));
    final path = await getTemporaryDirectory();
    final file = File('$path/$fileId');
    await file.writeAsString(response.data);
    return file;
  }
}
