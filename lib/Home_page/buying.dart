import 'package:flutter/material.dart';

import '../cart/cart_screen.dart';

// class buying extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                           child: Text(
//                             "Products",
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 letterSpacing: 2.0,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           )
//                       )
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
//                       },
//                       icon: Icon(Icons.shopping_cart)
//                   )
//                 ],
//               ),
//               SizedBox(height: 5),
//               products("Optimum Nutrition", "A high-quality whey protein blend known for its great taste and fast absorption, ideal for post-workout recovery","assets/product1.jpg"),
//               SizedBox(height: 20),
//               products("BSN", "A protein supplement with a mix of whey, casein, and other protein sources, providing sustained release and muscle support.", "assets/product2.jpg"),
//               SizedBox(height: 20),
//               products("Cellucor", "A pre-workout supplement featuring caffeine, beta-alanine, and creatine nitrate to enhance energy, endurance, and performance.", "assets/product3.jpg"),
//               SizedBox(height: 20),
//               products("MusclePharm", "A protein blend that includes whey, casein, and egg proteins to support muscle repair and growth.", "assets/product4.jpg"),
//               SizedBox(height: 20),
//               products("Bulk Supplements", "A pure creatine monohydrate supplement that helps increase strength, power, and muscle mass.", "assets/product5.jpg"),
//               SizedBox(height: 20),
//               products("Garden of Life", "An organic, plant-based protein powder made from raw, sprouted ingredients, suitable for vegans and those with dietary sensitivities.", "assets/product6.jpg"),
//               SizedBox(height: 20),
//               products("JYM Supplement Science", "A comprehensive pre-workout formula that includes a blend of ingredients like caffeine, creatine, and BCAAs for enhanced workout performance.", "assets/product7.jpg"),
//               SizedBox(height: 20),
//               products("Now Foods", "A high-quality fish oil supplement providing essential omega-3 fatty acids (EPA and DHA) for cardiovascular and joint health.", "assets/product8.jpg"),
//               SizedBox(height: 20),
//               products("RSP Nutrition", "A protein powder that combines whey protein with vegetables, vitamins, and minerals, offering a well-rounded nutritional profile.", "assets/product9.jpg"),
//               SizedBox(height: 20),
//               products("Universal Nutrition", "A comprehensive multivitamin and mineral supplement designed to support overall health and fitness goals, packed with essential nutrients and performance boosters.", "assets/product10.jpg"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   products(String title, String subtitle, String assetPath) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//                 offset: Offset(0, 7),
//                 color: Colors.green.shade900.withOpacity(.2),
//                 spreadRadius: 2,
//                 blurRadius: 10
//             )
//           ]
//       ),
//       child: ListTile(
//         title: Text(
//             title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14.0,
//           ),
//         ),
//         subtitle: Text(
//             subtitle,
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//             fontSize: 12.0,
//           ),
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           child: ClipOval(
//             child: Image.asset(
//               assetPath,
//               width: 100,
//               height: 100,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             IconButton(
//                 onPressed: () {
//
//                }, icon: Icon(Icons.add),iconSize: 15
//             ),
//
//             IconButton(onPressed: () { }, icon: Icon(Icons.remove),iconSize: 15)
//           ],
//         ),
//         tileColor: Colors.white,
//       ),
//     );
//   }
// }




class Buying extends StatefulWidget {
  @override
  _BuyingState createState() => _BuyingState();
}

class _BuyingState extends State<Buying> {
  // List to hold cart items
  List<Map<String, String>> cartItems = [];

  // Function to add item to cart
  void addToCart(String title,String assetPath) {
    setState(() {
      cartItems.add({
        'title': title,
        //'subtitle': subtitle,
        'assetPath': assetPath,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(
                            "Products",
                            style: TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                  ),
                  IconButton(
                      onPressed: () {
                        // Navigate to CartScreen and pass the cart items
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen(cartItems: [],)));
                      },
                      icon: const Icon(Icons.shopping_cart)
                  )
                ],
              ),
              SizedBox(height: 5),
              products("Optimum Nutrition", "A high-quality whey protein blend known for its great taste and fast absorption, ideal for post-workout recovery", "assets/product1.jpg"),
              SizedBox(height: 20),
              products("BSN", "A protein supplement with a mix of whey, casein, and other protein sources, providing sustained release and muscle support.", "assets/product2.jpg"),
              SizedBox(height: 20),
              products("Cellucor", "A pre-workout supplement featuring caffeine, beta-alanine, and creatine nitrate to enhance energy, endurance, and performance.", "assets/product3.jpg"),
              SizedBox(height: 20),
              products("MusclePharm", "A protein blend that includes whey, casein, and egg proteins to support muscle repair and growth.", "assets/product4.jpg"),
              SizedBox(height: 20),
              products("Bulk Supplements", "A pure creatine monohydrate supplement that helps increase strength, power, and muscle mass.", "assets/product5.jpg"),
              SizedBox(height: 20),
              products("Garden of Life", "An organic, plant-based protein powder made from raw, sprouted ingredients, suitable for vegans and those with dietary sensitivities.", "assets/product6.jpg"),
              SizedBox(height: 20),
              products("JYM Supplement Science", "A comprehensive pre-workout formula that includes a blend of ingredients like caffeine, creatine, and BCAAs for enhanced workout performance.", "assets/product7.jpg"),
              SizedBox(height: 20),
              products("Now Foods", "A high-quality fish oil supplement providing essential omega-3 fatty acids (EPA and DHA) for cardiovascular and joint health.", "assets/product8.jpg"),
              SizedBox(height: 20),
              products("RSP Nutrition", "A protein powder that combines whey protein with vegetables, vitamins, and minerals, offering a well-rounded nutritional profile.", "assets/product9.jpg"),
              SizedBox(height: 20),
              products("Universal Nutrition", "A comprehensive multivitamin and mineral supplement designed to support overall health and fitness goals, packed with essential nutrients and performance boosters.", "assets/product10.jpg"),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display product details
  Widget products(String title, String subtitle, String assetPath) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.green.shade900.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12.0,
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset(
              assetPath,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  addToCart(title,assetPath);
                  print("added");
                  print(cartItems);
                },
                icon: Icon(Icons.add),
                iconSize: 15
            ),
            IconButton(
                onPressed: () {
                  // Implement remove from cart functionality if needed
                },

                icon: Icon(Icons.remove),
                iconSize: 15
            ),
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
