import 'package:test_app/views/screen/home_product/product_details.dart';

import '../../../controllers/cartController/cart_controller.dart';
import '../../../controllers/productController/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../models/product/product.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ProductController _controller = ProductController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _controller.listProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          final products = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10), // Added margin
                  elevation: 3,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result =
                              await _controller.displayProduct(product.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewProduct(result),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.network(product.image,
                                  fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(20), // Increased padding
                            child: Center(
                              child: Text(
                                product.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      "\$",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(product.price.toStringAsFixed(2)),
                                  ],
                                ),
                              ),
                              Consumer<CartController>(
                                builder: (context, cartController, child) {
                                  bool isOnCart =
                                      cartController.isOnCart(product);
                                  return IconButton(
                                    onPressed: () {
                                      if (!isOnCart) {
                                        cartController.addToCart(product);

                                        // Show success MotionToast
                                        MotionToast.success(
                                          description: const Text(
                                            'Added to Cart',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ).show(context);
                                      } else {
                                        // Show error MotionToast
                                        MotionToast.error(
                                          description: const Text(
                                            'Already in Cart',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ).show(context);
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart_checkout_sharp,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
