class Recipe {
  int? id;
  String name;
  String preparationTime;
  List<String> ingredients;
  String description;
  String user;
  DateTime publicationTime;
  String image;

  Recipe({
    this.id,
    required this.name,
    required this.preparationTime,
    required this.ingredients,
    required this.description,
    required this.user,
    required this.publicationTime,
    required this.image,
  });

  // Método para convertir un mapa JSON en una instancia de Recipe
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      preparationTime: json['preparationTime'],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as String).split(', ')
          : [],
      description: json['description'],
      user: json['user'],
      publicationTime: DateTime.parse(json['publicationTime']),
      image: json['image'],
    );
  }

  // Método para convertir una instancia de Recipe en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'preparationTime': preparationTime,
      'ingredients': ingredients.join(', '),
      'description': description,
      'user': user,
      'publicationTime': publicationTime.toIso8601String(),
      'image': image,
    };
  }

  // Método para convertir un mapa de la base de datos a una instancia de Recipe
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      preparationTime: map['preparationTime'],
      ingredients: (map['ingredients'] as String).split(', '),
      description: map['description'],
      user: map['user'],
      publicationTime: DateTime.parse(map['publicationTime']),
      image: map['image'],
    );
  }

  // Método para convertir una instancia de Recipe en un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'preparationTime': preparationTime,
      'ingredients': ingredients.join(', '),
      'description': description,
      'user': user,
      'publicationTime': publicationTime.toIso8601String(),
      'image': image,
    };
  }
}