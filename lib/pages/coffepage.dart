import 'package:flutter/material.dart';


/// Flutter code sample for [Card].


class CoffePage extends StatelessWidget {
  const CoffePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coffee Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas
            mainAxisSpacing: 10, // Espaciado entre tarjetas en el eje principal (vertical)
            crossAxisSpacing: 10, // Espaciado entre tarjetas en el eje transversal (horizontal)
            childAspectRatio: 5 / 3, // Relación de aspecto para que las tarjetas tengan buena proporción
          ),
          itemCount: 10, // Número de tarjetas
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('LISTEN'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
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
