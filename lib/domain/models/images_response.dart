class ImagesResponse {
  // Date of when the object is created
  final int created;
  // Information of the image requested
  final List<Data> data;
  ImagesResponse({
    required this.created,
    required this.data,
  });

  // Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created': created,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  // Create the object from a Map<String, dynamic>
  factory ImagesResponse.fromMap(Map<String, dynamic> map) {
    return ImagesResponse(
      created: map['created'] as int,
      data: List<Data>.from(
        (map['data'] as List<dynamic>).map<Data>(
          (x) => Data.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Data {
  // url with the image requested
  final String url;

  Data(this.url);

  // convert the response to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  // convert a Map<String, dynamic> into Data
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      map['url'] as String,
    );
  }
}
