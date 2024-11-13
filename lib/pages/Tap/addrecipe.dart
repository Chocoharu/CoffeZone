import 'dart:async';
import 'dart:io';
import 'package:coffe_zone/class/recipe.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
  File? _imageFile;

  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription> _cameras = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _cameraController!.initialize();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _ingredientsController.dispose();
    _descriptionController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  // Método para tomar una foto usando la cámara
  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    try {
      await _initializeControllerFuture;
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagePath = path.join(
        appDir.path,
        '${DateTime.now()}.png',
      );

      await _cameraController!.takePicture().then((XFile file) {
        setState(() {
          _imageFile = File(file.path);
        });
      });
    } catch (e) {
      print('Error al tomar la foto: $e');
    }
  }

  // Método para seleccionar una foto desde la galería
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error al seleccionar la imagen: $e');
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Recipe newRecipe = Recipe(
        name: _nameController.text,
        preparationTime: _timeController.text,
        ingredients: _ingredientsController.text.split(',').map((s) => s.trim()).toList(),
        description: _descriptionController.text,
        user: user,
        publicationTime: DateTime.now(),
        image: _imageFile?.path ?? 'asset/Images/Capuccino.jpeg',
      );

      widget.onAddRecipe(newRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Agregar Receta'),
      ),*/
      body: SingleChildScrollView(
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
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Tomar Foto'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galería'),
                  ),
                ],
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
