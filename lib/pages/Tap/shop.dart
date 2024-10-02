import 'package:coffe_zone/pages/cart.dart';
import 'package:coffe_zone/structures/product.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  final List<Product> productsList;

  const Shop({super.key, required this.productsList});

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Map<Product, int> cartItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              if (cartItems.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(cartItems: cartItems),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El carrito está vacío.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.productsList.length,
        itemBuilder: (context, index) {
          final product = widget.productsList[index];
          int quantityInCart = cartItems[product] ?? 0;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Available Quantity: ${product.availableQuantity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Description: ${product.description}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Published by: ${product.user}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Publication Date: ${product.publicationDate.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: quantityInCart > 0
                                  ? () {
                                      setState(() {
                                        cartItems[product] = (cartItems[product] ?? 1) - 1;
                                        if (cartItems[product] == 0) {
                                          cartItems.remove(product);
                                        }
                                        product.availableQuantity++;
                                      });
                                    }
                                  : null,
                            ),
                            Text(quantityInCart.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  if (quantityInCart < product.availableQuantity) {
                                    cartItems[product] = (cartItems[product] ?? 0) + 1;
                                    product.availableQuantity--;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (quantityInCart < product.availableQuantity) {
                                cartItems[product] = (cartItems[product] ?? 0) + 1;
                                product.availableQuantity--;
                              }
                            });
                          },
                          child: const Text('Agregar al carrito'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
