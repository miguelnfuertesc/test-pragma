class CatBreed {
  final String? id;
  final String? name;
  final String? lifeSpan;
  final String? origin;
  final String? description;
  final String? history;
  final String? temperament;
  final String? image;

  CatBreed({
    required this.id,
    required this.name,
    required this.lifeSpan,
    required this.origin,
    required this.description,
    required this.history,
    required this.temperament,
    required this.image,
  });


  static CatBreed fromJson(Map<String, dynamic> json) {
    return CatBreed(
      id: json['id'] as String?,
      name: json['name'] as String?,
      lifeSpan: json['life_span'] as String?,
      origin: json['origin'] as String?,
      description: json['description'] as String?,
      history: json['history'] as String?,
      temperament: json['temperament'] as String?,
      image: (json['image'] ?? {})['url'] ?? '' as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'life_span': lifeSpan,
      'origin': origin,
      'description': description,
      'history': history,
      'temperament': temperament,
      'image': image,
    };
  }

}