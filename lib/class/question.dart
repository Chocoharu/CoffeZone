class Question {
  final String titulo;
  final String min;
  final String max;
  int valor;

  Question({required this.titulo, required this.min, required this.max, this.valor = 0});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      titulo: json['titulo'],
      min: json['min'],
      max: json['max'],
      valor: json['valor'] ?? 0,
    );
  }
}