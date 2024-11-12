class Recipe {
  final String name;
  final String preparationTime;
  final List<String> ingredients;
  final String description;
  final String user;
  final DateTime publicationTime;
  final String image;
  Recipe({
    required this.name,
    required this.preparationTime,
    required this.ingredients,
    required this.description,
    required this.user,
    required this.publicationTime,
    required this.image,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'description': description,
      'user': user,
      'publicationTime': publicationTime.toIso8601String(),
      'image': image,
    };
  }

  // Create a Recipe instance from a JSON map
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      preparationTime: json['preparationTime'],
      ingredients: List<String>.from(json['ingredients']),
      description: json['description'],
      user: json['user'],
      publicationTime: DateTime.parse(json['publicationTime']),
      image: json['image'],
    );
  }
}