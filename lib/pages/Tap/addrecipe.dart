import 'package:flutter/material.dart';
import 'package:coffe_zone/structures/recipe.dart';

class Addrecipe extends StatefulWidget {
  final Function(Recipe) onAddRecipe;

  const Addrecipe({super.key, required this.onAddRecipe});

  @override
  State<Addrecipe> createState() => _AddrecipeState();
}

class _AddrecipeState extends State<Addrecipe> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String user = 'Chef Juan';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Crear una nueva receta
      Recipe newRecipe = Recipe(
        name: _nameController.text,
        preparationTime: _timeController.text,
        ingredients: _ingredientsController.text.split(',').map((s) => s.trim()).toList(),
        description: _descriptionController.text,
        user: user,
        publicationTime: DateTime.now(),
        image: 'asset/screen/Capuccino.jpeg', 
      );

      
      widget.onAddRecipe(newRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre de la Receta'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese un nombre' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Tiempo de Preparación'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese el tiempo' : null,
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Ingredientes (separados por comas)'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese los ingredientes' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese una descripción' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Agregar Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}