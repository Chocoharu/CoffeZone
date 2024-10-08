import 'package:coffe_zone/pages/Tap/addrecipe.dart';
import 'package:coffe_zone/pages/Tap/coffepage.dart';
import 'package:coffe_zone/pages/draw/favouriterecipe.dart';
import 'package:coffe_zone/pages/Tap/shop.dart'; 
import 'package:coffe_zone/pages/draw/userpage.dart';
import 'package:coffe_zone/structures/product.dart';
import 'package:coffe_zone/structures/recipe.dart';
import 'package:coffe_zone/structures/user.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Recipe> recipes = [
    Recipe(
      name: 'Cappuccino',
      preparationTime: '5 minutes',
      ingredients: ['Coffee', 'Milk', 'Sugar'],
      description: 'A delicious coffee drink.',
      user: 'Chef Juan',
      publicationTime: DateTime.now(),
      image: 'asset/screen/Capuccino.jpeg',
    ),
  ];

  List<Recipe> favoriteRecipes = [];

  List<Product> products = [
    Product(
      name: 'Cafetera',
      price: 10.02,
      availableQuantity: 3,
      description: 'Cafetera italiana',
      user: 'Maria López',
      publicationDate: DateTime.now(),
    ),
    Product(
      name: 'Filtrador',
      price: 5.99,
      availableQuantity: 8,
      description: 'Filtro ideal para tus granos de cafe.',
      user: 'Julio Cesar',
      publicationDate: DateTime.now(),
    ),
  ];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
  super.initState();
  _widgetOptions = <Widget>[
    CoffePage(
      recipes: recipes,
      favoriteRecipes: favoriteRecipes,
      onFavoriteToggle: _toggleFavorite,
    ),
    Addrecipe(onAddRecipe: _addRecipe),
    Shop(productsList: products),
  ];
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      body: Center(
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Profile'),
              onTap: () {
                Navigator.pop(context);
                _navigateToUserProfile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
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
