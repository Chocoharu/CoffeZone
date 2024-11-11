import 'package:coffe_zone/class/recipe.dart';
import 'package:coffe_zone/utils/databasehelper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  Future<void> _captureImageWithCamera() async {
  final capturedFile = await _picker.pickImage(source: ImageSource.camera);
  if (capturedFile != null) {
    setState(() {
      _imageFile = File(capturedFile.path);
    });
  }
}

  void _submit() async {
  if (_formKey.currentState!.validate()) {
    Recipe newRecipe = Recipe(
      name: _nameController.text,
      preparationTime: _timeController.text,
      ingredients: _ingredientsController.text.split(',').map((s) => s.trim()).toList(),
      description: _descriptionController.text,
      user: 'Chef Juan',
      publicationTime: DateTime.now(),
      image: _imageFile?.path ?? '',
    );

    widget.onAddRecipe(newRecipe);

    await _dbHelper.insertRecipe(newRecipe);
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Receta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              const SizedBox(height: 10),
              if (_imageFile != null) Image.file(_imageFile!, height: 150),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Seleccionar Imagen'),
              ),
              ElevatedButton.icon(
                onPressed: _captureImageWithCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Cámara'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Guardar Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

