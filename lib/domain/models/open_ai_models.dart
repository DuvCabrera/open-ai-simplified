import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OpenAiModels {
  final List<Data> data;

  OpenAiModels(this.data);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory OpenAiModels.fromMap(Map<String, dynamic> map) {
    return OpenAiModels(
      List<Data>.from(
        (map['data'] as List<dynamic>).map<Data>(
          (x) => Data.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenAiModels.fromJson(String source) =>
      OpenAiModels.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Data {
  final String? id;
  final String? objec;
  final String? ownedBy;
  Data({
    this.id,
    this.objec,
    this.ownedBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'objec': objec,
      'ownedBy': ownedBy,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] != null ? map['id'] as String : null,
      objec: map['objec'] != null ? map['objec'] as String : null,
      ownedBy: map['ownedBy'] != null ? map['ownedBy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}
