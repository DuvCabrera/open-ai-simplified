class ConfigImages {
  final int n;
  final String size;
  ConfigImages({
    this.n = 2,
    this.size = "1024x1024",
  });

  ConfigImages copyWith({
    String? prompt,
    int? n,
    String? size,
  }) {
    return ConfigImages(
      n: n ?? this.n,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'n': n,
      'size': size,
    };
  }

  factory ConfigImages.fromMap(Map<String, dynamic> map) {
    return ConfigImages(
      n: map['n'] as int,
      size: map['size'] as String,
    );
  }
}
