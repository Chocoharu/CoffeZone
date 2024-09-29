class User {
  final String name;
  final String username;
  final String email;
  final DateTime birthDate;
  final String comment;

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.birthDate,
    this.comment = '',
  });

  // Método para convertir el objeto a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'comment': comment,
    };
  }

  // Método estático para crear un objeto User desde un mapa
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      birthDate: DateTime.parse(json['birthDate']),
      comment: json['comment'] ?? '',
    );
  }
}