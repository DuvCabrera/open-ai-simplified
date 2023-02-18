class ConfigFineTunes {
  /// The name of the base model to fine-tune. You can select one of "ada", "babbage", "curie", "davinci", or a fine-tuned model created after 2022-04-21
  final String model;

  /// The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.
  final int nEpochs;

  /// The batch size to use for training. The batch size is the number of training examples used to train a single forward and backward pass.
  /// By default, the batch size will be dynamically configured to be ~0.2% of the number of examples in the training set, capped at 256 - in general, we've found that larger batch sizes tend to work better for larger datasets.
  final int? batchSize;

  /// The learning rate multiplier to use for training. The fine-tuning learning rate is the original learning rate used for pretraining multiplied by this value.
  /// By default, the learning rate multiplier is the 0.05, 0.1, or 0.2 depending on final batch_size (larger learning rates tend to perform better with larger batch sizes). We recommend experimenting with values in the range 0.02 to 0.2 to see what produces the best results.
  final double? learningRateMultiplier;

  /// The weight to use for loss on the prompt tokens. This controls how much the model tries to learn to generate the prompt (as compared to the completion which always has a weight of 1.0), and can add a stabilizing effect to training when completions are short.
  /// If prompts are extremely long (relative to completions), it may make sense to reduce this weight so as to avoid over-prioritizing learning the prompt.
  final double promptLossWeight;

  /// If set, we calculate classification-specific metrics such as accuracy and F-1 score using the validation set at the end of every epoch. These metrics can be viewed in the results file.
  /// In order to compute classification metrics, you must provide a validation_file. Additionally, you must specify classification_n_classes for multiclass classification or classification_positive_class for binary classification.
  final bool computeClassificationMetrics;

  /// The number of classes in a classification task.
  /// This parameter is required for multiclass classification.
  final int? classificationNClasses;

  /// The positive class in binary classification.
  /// This parameter is needed to generate precision, recall, and F1 metrics when doing binary classification.
  final int? classificationPositiveClass;

  final String? suffix;

  ConfigFineTunes({
    this.model = 'curie',
    this.nEpochs = 4,
    this.batchSize,
    this.learningRateMultiplier,
    this.promptLossWeight = 0.01,
    this.computeClassificationMetrics = false,
    this.classificationNClasses,
    this.classificationPositiveClass,
    this.suffix,
  });

  ConfigFineTunes copyWith({
    String? model,
    int? nEpochs,
    int? batchSize,
    double? learningRateMultiplier,
    double? promptLossWeight,
    bool? computeClassificationMetrics,
    int? classificationNClasses,
    int? classificationPositiveClass,
    String? suffix,
  }) {
    return ConfigFineTunes(
      model: model ?? this.model,
      nEpochs: nEpochs ?? this.nEpochs,
      batchSize: batchSize ?? this.batchSize,
      learningRateMultiplier:
          learningRateMultiplier ?? this.learningRateMultiplier,
      promptLossWeight: promptLossWeight ?? this.promptLossWeight,
      computeClassificationMetrics:
          computeClassificationMetrics ?? this.computeClassificationMetrics,
      classificationNClasses:
          classificationNClasses ?? this.classificationNClasses,
      classificationPositiveClass:
          classificationPositiveClass ?? this.classificationPositiveClass,
      suffix: suffix ?? this.suffix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'n_epochs': nEpochs,
      'batch_size': batchSize,
      'learning_rate_multiplier': learningRateMultiplier,
      'prompt_loss_weight': promptLossWeight,
      'compute_classification_metrics': computeClassificationMetrics,
      'classification_n_classes': classificationNClasses,
      'classificationPositiveClass': classificationPositiveClass,
      'suffix': suffix,
    };
  }

  factory ConfigFineTunes.fromMap(Map<String, dynamic> map) {
    return ConfigFineTunes(
      model: map['model'] as String,
      nEpochs: map['n_epochs'] as int,
      batchSize: map['batch_size'] != null ? map['batch_size'] as int : null,
      learningRateMultiplier: map['learning_rate_multiplier'] != null
          ? map['learning_rate_multiplier'] as double
          : null,
      promptLossWeight: map['prompt_loss_weight'] as double,
      computeClassificationMetrics:
          map['compute_classification_metrics'] as bool,
      classificationNClasses: map['classification_n_classes'] != null
          ? map['classification_n_classes'] as int
          : null,
      classificationPositiveClass: map['classification_positive_class'] != null
          ? map['classification_positive_class'] as int
          : null,
      suffix: map['suffix'] != null ? map['suffix'] as String : null,
    );
  }
}
