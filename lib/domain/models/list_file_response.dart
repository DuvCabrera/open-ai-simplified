/// object thats represent the list of files return by the API
class ListFileResponse {
  final List<FileData> data;
  final String object;

  ListFileResponse(this.data, this.object);

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'object': object,
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory ListFileResponse.fromMap(Map<String, dynamic> map) {
    return ListFileResponse(
      List<FileData>.from(
        (map['data'] as List<dynamic>).map<FileData>(
          (x) => FileData.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['object'] as String,
    );
  }
}

/// object that contains the info about the file
class FileData {
  final String id;
  final String object;
  final int bytes;
  final int createdAt;
  final String filename;
  final String poupose;

  FileData(this.id, this.object, this.bytes, this.createdAt, this.filename,
      this.poupose);

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'bytes': bytes,
      'created_at': createdAt,
      'filename': filename,
      'poupose': poupose,
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory FileData.fromMap(Map<String, dynamic> map) {
    return FileData(
      map['id'] as String,
      map['object'] as String,
      map['bytes'] as int,
      map['created_at'] as int,
      map['filename'] as String,
      map['poupose'] as String,
    );
  }
}
