import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required List<Map<String, String>> cartItems});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = cart.items.values.toList()[index];
          return ListTile(
            title: Text(cartItem.name),
            subtitle: Text('Quantity: ${cartItem.quantity}'),
            trailing: Text('\$${cartItem.price * cartItem.quantity}'),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Consumer<CartProvider>(
//         builder: (context, cartProvider, child) {
//           if (cartProvider.items.isEmpty) {
//             return Center(
//               child: Text('Your cart is empty'),
//             );
//           }
//           return ListView.builder(
//             itemCount: cartProvider.items.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(cartProvider.items[index]!.name),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

