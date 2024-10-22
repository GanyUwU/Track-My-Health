import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Simulating a cart using a List to hold product IDs (or a product model).
  List<String> cart = [];

  
  // Example product data
  final List<Map<String, String>> products = [
    {'id': '1', 'name': 'Product 1'},
    {'id': '2', 'name': 'Product 2'},
    {'id': '3', 'name': 'Product 3'},
  ];

  // Function to handle adding a product to the cart
  void addToCart(String productId) {
    setState(() {
      cart.add(productId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
        actions: [
          // Cart Icon that shows the number of items in the cart
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to Cart Page or Show Cart Items
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cart.length}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']!),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                addToCart(product['id']!); // Call addToCart on icon click
              },
            ),
          );
        },
      ),
    );
  }
}
