class ConfigImages {
  /// number of images will be delivery 1 to 10
  final int n;

  /// Size of the images generated ex: 1024x1024
  /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
  final String size;
  ConfigImages({
    this.n = 2,
    this.size = "1024x1024",
  });

  /// Generate a new ConfigImages object from the original object
  ConfigImages copyWith({
    int? n,
    String? size,
  }) {
    return ConfigImages(
      n: n ?? this.n,
      size: size ?? this.size,
    );
  }

  /// convert the response to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'n': n,
      'size': size,
    };
  }

  /// convert a Map<String, dynamic> into ImagesResponse
  factory ConfigImages.fromMap(Map<String, dynamic> map) {
    return ConfigImages(
      n: map['n'] as int,
      size: map['size'] as String,
    );
  }
}
