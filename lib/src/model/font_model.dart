class FontModel {
  final String url;
  final String family;
  final int? weight;

  FontModel({
    required this.url,
    required this.family,
    this.weight,
  });

  factory FontModel.fromJson(Map<String, dynamic> json) {
    return FontModel(
      url: json['url'] as String,
      family: json['family'] as String,
      weight: json['weight'] != null ? json['weight'] as int : 800,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'family': family,
      'weight': weight ?? 400,
    };
  }
}
