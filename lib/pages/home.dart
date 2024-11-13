import 'package:coffe_zone/pages/Tap/addrecipe.dart';
import 'package:coffe_zone/pages/Tap/coffepage.dart';
import 'package:coffe_zone/pages/draw/favouriterecipe.dart';
import 'package:coffe_zone/pages/Tap/shop.dart'; 
import 'package:coffe_zone/pages/draw/userpage.dart';
import 'package:coffe_zone/class/product.dart';
import 'package:coffe_zone/class/recipe.dart';
import 'package:coffe_zone/class/user.dart';
import 'package:flutter/services.dart';
//import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool isLoading = true;
Future<List<Recipe>> loadRecipesFromAssets(String filePath) async {
  try {
    final jsonString = await rootBundle.loadString(filePath);
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((json) => Recipe.fromJson(json as Map<String, dynamic>)).toList();
  } catch (e) {
    print('Error loading recipes: $e');
    return [];
  }
}

Future<List<Product>> loadProductsFromAssets(String filePath) async {
  try {
    final jsonString = await rootBundle.loadString(filePath);
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
  } catch (e) {
    print('Error loading products: $e');
    return [];
  }
}
  List<Recipe> recipes = [];

  List<Recipe> favoriteRecipes = [];

  List<Product> products = [];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
  super.initState();
  _loadData();
}
Future<void> _loadData() async {
  recipes = await loadRecipesFromAssets('asset/JSON/recipe.json');
  products = await loadProductsFromAssets('asset/JSON/product.json');

  setState(() {
    _widgetOptions = <Widget>[
      CoffePage(
        recipes: recipes,
        favoriteRecipes: favoriteRecipes,
        onFavoriteToggle: _toggleFavorite,
      ),
      Addrecipe(onAddRecipe: _addRecipe),
      Shop(productsList: products),
    ];
    isLoading = false;
  });
}

  void _addRecipe(Recipe recipe) {
    setState(() {
      recipes.add(recipe);
      _widgetOptions[0] = CoffePage(recipes: recipes, onFavoriteToggle: _toggleFavorite, favoriteRecipes: favoriteRecipes,);
    });
  }

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToUserProfile() {
    User exampleUser = User(
      name: 'Juan Pérez',
      username: 'juanp',
      email: 'juan.perez@example.com',
      birthDate: DateTime(1990, 1, 1),
      comment: 'Me encanta el café.',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Userpage(user: exampleUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Coffee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.brown),
              title: const Text('User Profile'),
              onTap: () {
                Navigator.pop(context);
                _navigateToUserProfile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.brown),
              title: const Text('Favourites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favouriterecipe(favoriteRecipes: favoriteRecipes),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}