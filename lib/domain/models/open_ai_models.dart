class OpenAiModels {
  /// List with the information about models
  final List<Data> data;

  OpenAiModels(this.data);

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory OpenAiModels.fromMap(Map<String, dynamic> map) {
    return OpenAiModels(
      List<Data>.from(
        (map['data'] as List<dynamic>).map<Data>(
          (x) => Data.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Data {
  /// id of the model [used on the configs]
  final String? id;

  /// type of object
  final String? objec;

  /// owner of the model
  final String? ownedBy;
  Data({
    this.id,
    this.objec,
    this.ownedBy,
  });

  /// Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'objec': objec,
      'ownedBy': ownedBy,
    };
  }

  /// Create the object from a Map<String, dynamic>
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] != null ? map['id'] as String : null,
      objec: map['objec'] != null ? map['objec'] as String : null,
      ownedBy: map['ownedBy'] != null ? map['ownedBy'] as String : null,
    );
  }
}
