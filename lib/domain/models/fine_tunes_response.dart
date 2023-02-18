class FineTunesResponse {
  final String id;
  final String object;
  final String model;
  final int createdAt;
  final List<Events?> events;
  final String? fineTunedModel;
  final Map<String, dynamic> hyperparams;
  final String? organizationId;
  final List<dynamic> resultFiles;
  final String status;
  final List<dynamic> validationFiles;
  final List<TrainingFiles> trainingFiles;
  final int? updatedAt;

  FineTunesResponse(
      this.id,
      this.object,
      this.model,
      this.createdAt,
      this.events,
      this.fineTunedModel,
      this.hyperparams,
      this.organizationId,
      this.resultFiles,
      this.status,
      this.validationFiles,
      this.trainingFiles,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'model': model,
      'created_at': createdAt,
      'events': events.map((x) => x?.toMap()).toList(),
      'fine_tuned_model': fineTunedModel,
      'hyperparams': hyperparams,
      'organization_id': organizationId,
      'result_files': resultFiles,
      'status': status,
      'validation_files': validationFiles,
      'training_files': trainingFiles.map((x) => x.toMap()).toList(),
      'updated_at': updatedAt,
    };
  }

  factory FineTunesResponse.fromMap(Map<String, dynamic> map) {
    return FineTunesResponse(
      map['id'] as String,
      map['object'] as String,
      map['model'] as String,
      map['created_at'] as int,
      List<Events?>.from(
        (map['events'] as List<dynamic>).map<Events?>(
          (x) => Events.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['fine_tuned_model'] != null
          ? map['fine_tuned_model'] as String
          : null,
      Map<String, dynamic>.from((map['hyperparams'] as Map<String, dynamic>)),
      map['organization_id'] != null ? map['organization_id'] as String : null,
      List<dynamic>.from((map['result_files'] as List<dynamic>)),
      map['status'] as String,
      List<dynamic>.from((map['validation_files'] as List<dynamic>)),
      List<TrainingFiles>.from(
        (map['training_files'] as List<dynamic>).map<TrainingFiles>(
          (x) => TrainingFiles.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['updated_at'] != null ? map['updated_at'] as int : null,
    );
  }
}

class TrainingFiles {
  final String id;
  final String object;
  final int bytes;
  final int createdAt;
  final String filename;
  final String purpose;

  TrainingFiles(this.id, this.object, this.bytes, this.createdAt, this.filename,
      this.purpose);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'bytes': bytes,
      'created_at': createdAt,
      'filename': filename,
      'purpose': purpose,
    };
  }

  factory TrainingFiles.fromMap(Map<String, dynamic> map) {
    return TrainingFiles(
      map['id'] as String,
      map['object'] as String,
      map['bytes'] as int,
      map['created_at'] as int,
      map['filename'] as String,
      map['purpose'] as String,
    );
  }
}

class Events {
  final String? object;
  final int? createdAt;
  final String? level;
  final String? message;

  Events(this.object, this.createdAt, this.level, this.message);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'created_at': createdAt,
      'level': level,
      'message': message,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      map['object'] != null ? map['object'] as String : null,
      map['created_at'] != null ? map['created_at'] as int : null,
      map['level'] != null ? map['level'] as String : null,
      map['message'] != null ? map['message'] as String : null,
    );
  }
}
