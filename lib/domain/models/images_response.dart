class ImagesResponse {
  final int created;
  final Data data;
  ImagesResponse({
    required this.created,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created': created,
      'data': data.toMap(),
    };
  }

  factory ImagesResponse.fromMap(Map<String, dynamic> map) {
    return ImagesResponse(
      created: map['created'] as int,
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  final String url;

  Data(this.url);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      map['url'] as String,
    );
  }
}
