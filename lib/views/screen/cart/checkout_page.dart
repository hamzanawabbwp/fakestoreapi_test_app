import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cartController/cart_controller.dart';
import '../home/home.dart'; // Import the CartController

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    final cart = cartController.cartItems;
    final totalPrice = cart.fold(
        0.0, (sum, item) => sum + item.product!.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Order Summary
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...cart.map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.product!.title),
                            subtitle: Text('Qty: ${item.quantity}'),
                            trailing: Text(
                                '\$ ${item.product!.price * item.quantity}'),
                          )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$ ${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // User Info Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    inputInfo(
                      Icons.person,
                      'Name',
                      'Input Your Name',
                      _nameController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    inputInfo(
                      Icons.phone,
                      'Phone No.',
                      'Input Your Phone Number',
                      _phoneController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                    inputInfo(
                      Icons.email_rounded,
                      'E-Mail',
                      'Input Your E-Mail',
                      _emailController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your email'
                          : null,
                    ),
                    inputInfo(
                      Icons.domain,
                      'Address',
                      'Input Your Address',
                      _addressController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your address'
                          : null,
                    ),
                    inputInfo(
                      Icons.location_city_outlined,
                      'City',
                      'Input Your City',
                      _cityController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your city'
                          : null,
                    ),
                    inputInfo(
                      Icons.location_city,
                      'ZipCode',
                      'Input Your Zipcode',
                      _zipCodeController,
                      (value) => value == null || value.isEmpty
                          ? 'Please enter your zipcode'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Show success MotionToast
                            MotionToast.success(
                              description: const Text(
                                'Congratulations, your order has been placed!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ).show(context);

                            // Navigate to the home screen immediately
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Home()), // Ensure Home widget is correctly defined
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget inputInfo(
    IconData icon,
    String label,
    String hintText,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(icon, color: Colors.grey),
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        validator: validator,
      ),
    );
  }
}
