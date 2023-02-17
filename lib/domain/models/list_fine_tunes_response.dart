import 'package:open_ai_simplified/domain/models/fine_tunes_response.dart';

class ListFineTunesResponse {
  final String object;
  final List<FineTunesResponse> data;

  ListFineTunesResponse(this.object, this.data);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ListFineTunesResponse.fromMap(Map<String, dynamic> map) {
    return ListFineTunesResponse(
      map['object'] as String,
      List<FineTunesResponse>.from(
        (map['data'] as List<dynamic>).map<FineTunesResponse>(
          (x) => FineTunesResponse.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
