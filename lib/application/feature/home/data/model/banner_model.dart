class BannerModel {
  int? id;
  String? title;
  String? subtitle;
  String? imageUrl;
  String? actionUrl;
  String? type;

  BannerModel({
    this.id,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.actionUrl,
    this.type,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      actionUrl: json['actionUrl'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'actionUrl': actionUrl,
        'type': type,
      };
}
