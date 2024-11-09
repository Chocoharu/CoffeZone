class Product {
  final String name;
  final double price;
  int availableQuantity;
  final String description;
  final String user;
  final DateTime publicationDate;

  Product({
    required this.name,
    required this.price,
    required this.availableQuantity,
    required this.description,
    required this.user,
    required this.publicationDate,
  });
  // Convert a Product instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'availableQuantity': availableQuantity,
      'description': description,
      'user': user,
      'publicationDate': publicationDate.toIso8601String(),
    };
  }

  // Create a Product instance from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      availableQuantity: json['availableQuantity'],
      description: json['description'],
      user: json['user'],
      publicationDate: DateTime.parse(json['publicationDate']),
    );
  }
}