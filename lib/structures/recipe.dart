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
}