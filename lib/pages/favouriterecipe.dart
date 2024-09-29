import 'package:coffe_zone/structures/recipe.dart';
import 'package:flutter/material.dart';

class Favouriterecipe extends StatelessWidget {
  final List<Recipe> favoriteRecipes; // Cambié el nombre para mayor claridad
  const Favouriterecipe({super.key, required this.favoriteRecipes, required List<Recipe> recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 5 / 3,
          ),
          itemCount: favoriteRecipes.length, // Usa la lista de recetas favoritas
          itemBuilder: (context, index) {
            final recipe = favoriteRecipes[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tiempo de preparación: ${recipe.preparationTime}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ingredientes: ${recipe.ingredients.join(', ')}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Descripción: ${recipe.description}',
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Publicado por: ${recipe.user}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Fecha de publicación: ${recipe.publicationTime.toLocal().toString().split(' ')[0]}', // Formato de fecha
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
