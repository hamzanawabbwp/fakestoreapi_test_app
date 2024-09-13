import 'package:test_app/controllers/cartController/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motion_toast/motion_toast.dart';
import '../cart/checkout_page.dart';

class ViewProduct extends StatefulWidget {
  final dynamic result;
  const ViewProduct(this.result, {super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          children: [
            Text(
              "Test App",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to CheckoutPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOutPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(widget.result.image),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.result.title,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 30, right: 30),
                child: Text(widget.result.description,
                    textAlign: TextAlign.justify),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "\$",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          '${widget.result.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Consumer<CartController>(
                      builder: (context, cartController, child) {
                        bool isOnCart = cartController.isOnCart(widget.result);
                        return IconButton(
                          onPressed: () {
                            if (!isOnCart) {
                              cartController.addToCart(widget.result);

                              // Show success MotionToast
                              MotionToast.success(
                                description: const Text(
                                  'Added to cart',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ).show(context);
                            } else {
                              // Show error MotionToast
                              MotionToast.error(
                                description: const Text(
                                  'Already in cart',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ).show(context);
                            }
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.shopping_cart_checkout,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
