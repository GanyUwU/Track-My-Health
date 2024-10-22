import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'cart_provider.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('\$$price'),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).addItem(id, name, price);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name added to cart!'),
            ),
          );
        },
      ),
    );
  }
}
