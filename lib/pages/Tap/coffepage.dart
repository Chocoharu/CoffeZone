import 'package:coffe_zone/class/recipe.dart';
import 'package:coffe_zone/pages/editrecipe.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


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
  // ignore: library_private_types_in_public_api
  _CoffePageState createState() => _CoffePageState();
}

class _CoffePageState extends State<CoffePage> {
  void _shareRecipe(Recipe recipe) {
    // Construimos un mensaje con los detalles de la receta
    final String recipeDetails = '''
  🍵 *${recipe.name}*

  🕒 Tiempo de preparación: ${recipe.preparationTime}
  📜 Ingredientes: ${recipe.ingredients.join(', ')}

  📖 Descripción:
  ${recipe.description}

  👤 Publicado por: ${recipe.user}
  📅 Fecha de publicación: ${recipe.publicationTime.toLocal().toString().split(' ')[0]}

  ¡Prueba esta deliciosa receta desde Coffee Zone!
    ''';

    // Usamos Share.share para compartir el mensaje a través de cualquier app compatible (WhatsApp, correo, etc.)
    Share.share(
      recipeDetails,
      subject: '¡Descubre esta receta de ${recipe.name}!',
    );
  }
  
 void _addNewRecipe(Recipe editedRecipe) {
    setState(() {
      widget.recipes.add(editedRecipe);  // Se agrega como una receta nueva
    });
  }
  void _editRecipe(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipe(
          recipe: recipe,
          onSaveEditedRecipe: _addNewRecipe,  // Aquí se usa la función que maneja el agregar como nueva
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.recipes.length,
          itemBuilder: (context, index) {
            final recipe = widget.recipes[index];
            final isFavorite = widget.favoriteRecipes.contains(recipe);

            return Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tiempo de preparación: ${recipe.preparationTime}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ingredientes: ${recipe.ingredients.join(', ')}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Descripción: ${recipe.description}',
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Publicado por: ${recipe.user}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fecha de publicación: ${recipe.publicationTime.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.onFavoriteToggle(recipe);
                                  });
                                },
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _shareRecipe(recipe);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (recipe.user != 'mi_usuario') { // Asegúrate de comparar con el usuario actual
                                    _editRecipe(recipe);
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        )
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