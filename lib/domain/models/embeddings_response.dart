import 'package:open_ai_simplified/domain/models/models.dart';

class EmbeddingsResponse {
  /// type of the object
  final String object;

  /// list of the values that brings the Embedding
  final List<EmbeddingData> data;

  /// model used to make the embedding
  final String model;

  /// object that shows how much Tokens were spended on the request + response
  final Usage usage;

  EmbeddingsResponse(this.object, this.data, this.model, this.usage);

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'data': data.map((x) => x.toMap()).toList(),
      'model': model,
      'usage': usage.toMap(),
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory EmbeddingsResponse.fromMap(Map<String, dynamic> map) {
    return EmbeddingsResponse(
      map['object'] as String,
      List<EmbeddingData>.from(
        (map['data'] as List<dynamic>).map<EmbeddingData>(
          (x) => EmbeddingData.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['model'] as String,
      Usage.fromMap(map['usage'] as Map<String, dynamic>),
    );
  }
}

class EmbeddingData {
  final String object;
  final List<double> embedding;
  final int index;

  EmbeddingData(this.object, this.embedding, this.index);

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'embedding': embedding,
      'index': index,
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory EmbeddingData.fromMap(Map<String, dynamic> map) {
    return EmbeddingData(
      map['object'] as String,
      List<double>.from((map['embedding'] as List<double>)),
      map['index'] as int,
    );
  }
}
