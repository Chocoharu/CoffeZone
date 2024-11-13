import 'dart:convert';
import 'package:coffe_zone/class/feedbackcategory.dart';
import 'package:coffe_zone/utils/emailservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Validation extends StatefulWidget {
  const Validation({super.key});

  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  List<FeedbackCategory> categories = [];
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      // Cargar el archivo JSON desde assets
      final String response = await rootBundle.loadString('asset/JSON/validacion.json');
      
      // Decodificar el JSON en un Map
      final Map<String, dynamic> data = json.decode(response);
      
      // Convertir el Map en una lista de categorías de retroalimentación
      categories = data.keys.map((category) {
        return FeedbackCategory.fromJson(data, category);
      }).toList();

      // Actualizar el estado para refrescar la UI
      setState(() {});
    } catch (e) {
      print('Error al cargar las preguntas: $e');
    }
  }
  void sendFeedback() async {
    String feedbackContent = '';

    for (var category in categories) {
      feedbackContent += '\n${category.category}:\n';
      for (var question in category.questions) {
        feedbackContent += '${question.titulo}: ${question.valor} estrellas\n';
      }
    }

    await EmailService.sendEmail(userName, userEmail, feedbackContent);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Retroalimentación enviada exitosamente!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tu Opinión')),
      body: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) => userName = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  onChanged: (value) => userEmail = value,
                ),
                ...categories.map((category) {
                  return ExpansionTile(
                    title: Text(category.category),
                    children: category.questions.map((q) {
                      return ListTile(
                        title: Text(q.titulo),
                        subtitle: Slider(
                          value: q.valor.toDouble(),
                          min: 0,
                          max: 5,
                          divisions: 5,
                          label: '${q.valor} estrellas',
                          onChanged: (value) {
                            setState(() => q.valor = value.toInt());
                          },
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: sendFeedback,
                  child: const Text('Enviar Retroalimentación'),
                )
              ],
            ),
    );
  }
}
