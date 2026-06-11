class ChatbotResponse {
  final String answer;
  final Map<String, List<String>> imagesMap;
  final List<ExerciseModel> exercisesList;
  final ImageAccuracyModel imageAccuracy;

  ChatbotResponse({
    required this.answer,
    required this.imagesMap,
    required this.exercisesList,
    required this.imageAccuracy,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      answer: json['answer']?.toString() ?? '',
      imagesMap: _parseImagesMap(json['images_map']),
      exercisesList: _parseExercises(json['exercises_list']),
      imageAccuracy: ImageAccuracyModel.fromJson(json['image_accuracy']),
    );
  }

  static Map<String, List<String>> _parseImagesMap(dynamic value) {
    if (value is! Map) return {};

    return value.map((key, images) {
      final imageUrls = images is List
          ? images
                .where((image) => image != null && image.toString().isNotEmpty)
                .map((image) => image.toString())
                .toList()
          : <String>[];

      return MapEntry(key.toString(), imageUrls);
    });
  }

  static List<ExerciseModel> _parseExercises(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((exercise) => ExerciseModel.fromJson(exercise))
        .toList();
  }
}

class ExerciseModel {
  static const String placeholderTarget = 'Muscle Group';
  static const String placeholderHowTo =
      'Perform the exercise using proper form.';

  final String name;
  final String target;
  final String howTo;
  final String? imageStart;
  final String? imageEnd;

  ExerciseModel({
    required this.name,
    required this.target,
    required this.howTo,
    this.imageStart,
    this.imageEnd,
  });

  factory ExerciseModel.fromJson(Map<dynamic, dynamic> json) {
    return ExerciseModel(
      name: json['name']?.toString() ?? '',
      target: json['target']?.toString() ?? '',
      howTo: json['how_to']?.toString() ?? '',
      imageStart: _nullableString(json['image_start']),
      imageEnd: _nullableString(json['image_end']),
    );
  }

  bool get hasActualContent {
    return imageStart != null ||
        imageEnd != null ||
        target.trim().toLowerCase() != placeholderTarget.toLowerCase() ||
        howTo.trim().toLowerCase() != placeholderHowTo.toLowerCase();
  }

  static String? _nullableString(dynamic value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
      return null;
    }
    return text;
  }
}

class ImageAccuracyModel {
  final int matched;
  final int total;
  final int percent;

  const ImageAccuracyModel({
    required this.matched,
    required this.total,
    required this.percent,
  });

  factory ImageAccuracyModel.fromJson(dynamic json) {
    if (json is! Map) return const ImageAccuracyModel.empty();

    return ImageAccuracyModel(
      matched: int.tryParse(json['matched']?.toString() ?? '') ?? 0,
      total: int.tryParse(json['total']?.toString() ?? '') ?? 0,
      percent: int.tryParse(json['percent']?.toString() ?? '') ?? 0,
    );
  }

  const ImageAccuracyModel.empty() : matched = 0, total = 0, percent = 0;
}
