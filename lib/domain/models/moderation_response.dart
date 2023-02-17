class ModerationResponse {
  final String id;
  final String model;
  final List<Results> results;

  ModerationResponse(this.id, this.model, this.results);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory ModerationResponse.fromMap(Map<String, dynamic> map) {
    return ModerationResponse(
      map['id'] as String,
      map['model'] as String,
      List<Results>.from(
        (map['results'] as List<dynamic>).map<Results>(
          (x) => Results.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Results {
  final Map<String, dynamic> categories;
  final Map<String, dynamic> categoryScores;
  final bool flagged;

  Results(this.categories, this.categoryScores, this.flagged);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories,
      'category_scores': categoryScores,
      'flagged': flagged,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      Map<String, dynamic>.from((map['categories'] as Map<String, dynamic>)),
      Map<String, dynamic>.from(
          (map['category_scores'] as Map<String, dynamic>)),
      map['flagged'] as bool,
    );
  }
}
