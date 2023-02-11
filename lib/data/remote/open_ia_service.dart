import 'package:dio/dio.dart';
import 'package:open_ai_simplified/data/infraestructure/url_builder.dart';
import 'package:open_ai_simplified/domain/models/completion_response.dart';

import '../../domain/models/config_ia.dart';

class OpenIAService {
  final Dio dio;

  OpenIAService(this.dio);

  Future<CompletionResponse> getCompletion({
    required String prompt,
    required String apiKey,
    required Config config,
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

      return CompletionResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
