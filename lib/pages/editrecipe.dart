import 'package:coffe_zone/class/recipe.dart';
import 'package:flutter/material.dart';

class EditRecipe extends StatefulWidget {
  final Recipe recipe;

  const EditRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  late TextEditingController _nameController;
  late TextEditingController _preparationTimeController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe.name);
    _preparationTimeController = TextEditingController(text: widget.recipe.preparationTime);
    _descriptionController = TextEditingController(text: widget.recipe.description);
    _ingredientsController = TextEditingController(text: widget.recipe.ingredients.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _preparationTimeController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  void _saveEditedRecipe() {
    final updatedRecipe = Recipe(
      name: _nameController.text,
      preparationTime: _preparationTimeController.text,
      ingredients: _ingredientsController.text.split(', '),
      description: _descriptionController.text,
      user: widget.recipe.user, // Mantener el usuario original
      publicationTime: widget.recipe.publicationTime,
      image: widget.recipe.image,
    );

    Navigator.pop(context, updatedRecipe); // Volver y pasar la receta editada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre de la receta'),
            ),
            TextField(
              controller: _preparationTimeController,
              decoration: const InputDecoration(labelText: 'Tiempo de preparación'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(labelText: 'Ingredientes (separados por coma)'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEditedRecipe,
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}