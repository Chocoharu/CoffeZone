import 'package:flutter/material.dart';


/// Flutter code sample for [Card].


class CoffePage extends StatelessWidget {
  const CoffePage({super.key});

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
            childAspectRatio: 5 / 3, 
          ),
          itemCount: 10, 
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAlias, 
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'asset/screen/Capuccino.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity, 
                    width: double.infinity,
                  ),
                  const ListTile(
                        leading: Icon(Icons.coffee, color: Colors.white),
                        title: Text(
                          'Cappuccino',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  const Center(
                    child: Text(
                      'Hola',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {/* ... */},
                      icon: const Icon(Icons.heart_broken),
                      color: Colors.white,
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

