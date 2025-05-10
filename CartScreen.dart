import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// Dummy cart items
    final List<CartItem> cartItems = [
      CartItem(name: 'Custom Exhaust System', price: 599.99, quantity: 1),
      CartItem(name: 'LED Headlight Kit', price: 299.99, quantity: 2),
      CartItem(name: 'Performance Chip', price: 149.99, quantity: 1),
    ];

    double total = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart', style: TextStyle(color: Colors.orange)),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(cartItems[index].name, style: const TextStyle(color: Colors.white)),
              subtitle: Text('\$${cartItems[index].price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.orange)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.orange),
                    onPressed: () {
// Implement decrease quantity
                    },
                  ),
                  Text('${cartItems[index].quantity}', style: const TextStyle(color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.orange),
                    onPressed: () {
// Implement increase quantity
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              ElevatedButton(
                onPressed: () {
// Implement checkout functionality
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

