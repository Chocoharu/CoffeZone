import 'package:flutter/material.dart';
import 'package:coffe_zone/structures/product.dart';

class Cart extends StatefulWidget {
  final Map<Product, int> cartItems;

  const Cart({super.key, required this.cartItems});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.entries
        .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final product = widget.cartItems.keys.elementAt(index);
                  final quantity = widget.cartItems[product] ?? 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${product.price.toStringAsFixed(2)}'),
                          Text('Quantity: $quantity'),
                          Text('Subtotal: \$${(product.price * quantity).toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.cartItems.remove(product);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _completePurchase(context);
              },
              child: const Text('Realizar compra'),
            ),
          ],
        ),
      ),
    );
  }

  void _completePurchase(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compra completada'),
          content: const Text('Gracias por su compra.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.cartItems.clear();
                });
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
