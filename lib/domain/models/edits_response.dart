import 'package:open_ai_simplified/domain/models/usage.dart';

class EditsResponse {
  // type of the object
  final String object;
  // date of the moment were the object was created
  final int created;
  // list of the values that brings the Edit
  final List<ChoicesEdit> choices;
  // object that shows how much Tokens were spended on the request + response
  final Usage usage;

  EditsResponse(this.object, this.created, this.choices, this.usage);

  // Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'created': created,
      'choices': choices.map((x) => x.toMap()).toList(),
      'usage': usage.toMap(),
    };
  }

  // Create the object from a Map<String, dynamic>
  factory EditsResponse.fromMap(Map<String, dynamic> map) {
    return EditsResponse(
      map['object'] as String,
      map['created'] as int,
      List<ChoicesEdit>.from(
        (map['choices'] as List<dynamic>).map<ChoicesEdit>(
          (x) => ChoicesEdit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      Usage.fromMap(map['usage'] as Map<String, dynamic>),
    );
  }
}

class ChoicesEdit {
  // the text edited
  final String text;
  // index on de list of texts editeds
  final int index;

  ChoicesEdit(this.text, this.index);

  // Converts the object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
    };
  }

  // Create the object from a Map<String, dynamic>
  factory ChoicesEdit.fromMap(Map<String, dynamic> map) {
    return ChoicesEdit(
      map['text'] as String,
      map['index'] as int,
    );
  }
}
