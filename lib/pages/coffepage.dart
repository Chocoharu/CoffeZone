import 'package:coffe_zone/structures/recipe.dart';
import 'package:flutter/material.dart';

class CoffePage extends StatefulWidget {
  final List<Recipe> recipes;
  final List<Recipe> favoriteRecipes;
  final Function(Recipe) onFavoriteToggle;

  const CoffePage({
    super.key,
    required this.recipes,
    required this.favoriteRecipes,
    required this.onFavoriteToggle,
  });

  @override
  _CoffePageState createState() => _CoffePageState();
}

class _CoffePageState extends State<CoffePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.8,
          ),
          itemCount: widget.recipes.length,
          itemBuilder: (context, index) {
            final recipe = widget.recipes[index];
            final isFavorite = widget.favoriteRecipes.contains(recipe);

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
                          'Fecha de publicación: ${recipe.publicationTime.toLocal().toString().split(' ')[0]}', 
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.onFavoriteToggle(recipe); // Activa el callback y actualiza el estado
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
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