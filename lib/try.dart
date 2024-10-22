import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  // List of available items
  final List<String> _items = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
  ];

  // Set to store items that are added to the cart
  final Set<String> _cart = {};

  // Function to add or remove item from cart
  void _toggleCartItem(String item) {
    setState(() {
      if (_cart.contains(item)) {
        _cart.remove(item);
      } else {
        _cart.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: _cart.toList()),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final isInCart = _cart.contains(item);
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(
                isInCart ? Icons.remove_circle : Icons.add_circle,
                color: isInCart ? Colors.red : Colors.green,
              ),
              onPressed: () {
                _toggleCartItem(item);
              },
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<String> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('No items in the cart'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]),
          );
        },
      ),
    );
  }
}
