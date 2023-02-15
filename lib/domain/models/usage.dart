class Usage {
  // Tokens spended with the request
  final int? promptTokens;
  // Tokens Spended with the result
  final int? completionTokens;
  // Total of tokens spended
  final int? totalTokens;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  // Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promptTokens': promptTokens,
      'completionTokens': completionTokens,
      'totalTokens': totalTokens,
    };
  }

  // Create the object from a Map<String, dynamic>
  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      promptTokens:
          map['promptTokens'] != null ? map['promptTokens'] as int : null,
      completionTokens: map['completionTokens'] != null
          ? map['completionTokens'] as int
          : null,
      totalTokens:
          map['totalTokens'] != null ? map['totalTokens'] as int : null,
    );
  }
}
