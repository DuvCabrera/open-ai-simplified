import 'package:dio/dio.dart';
import 'package:open_ai_simplified/data/infraestructure/url_builder.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

class OpenIAService {
  final Dio dio;

  OpenIAService(this.dio);

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

  Future<OpenAiModels> getModelsLis({
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
}
