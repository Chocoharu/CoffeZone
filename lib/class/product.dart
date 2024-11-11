class Product {
  int? id;
  final String name;
  final double price;
  int availableQuantity;
  final String description;
  final String user;
  final DateTime publicationDate;

  Product({
    this.id,
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
      'id': id,
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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      availableQuantity: json['availableQuantity'],
      description: json['description'],
      user: json['user'],
      publicationDate: DateTime.parse(json['publicationDate']),
    );
  }
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      availableQuantity: int.parse(map['availableQuantity']),
      description: map['description'],
      user: map['user'],
      publicationDate: DateTime.parse(map['publicationTime']),
    );
  }

  // Método para convertir una instancia de Recipe en un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'availableQuantity': availableQuantity,
      'description': description,
      'user': user,
      'publicationTime': publicationDate.toIso8601String(),
    };
  }
}
