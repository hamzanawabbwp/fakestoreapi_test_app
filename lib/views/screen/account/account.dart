import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../controllers/userController/user_controller.dart';
import '../../../models/user/user.dart';
import '../../../utils/app_colors.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final UserController _controller = UserController();
  late User? _user;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = null;
    _loadUser();
  }

  void _loadUser() async {
    _user = await _controller.displayUser();
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: 'Back',
          ),
          title: const Text(
            'Account',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor:
              primaryColor // Optional: Set the background color of the AppBar
          ),
      body: _user != null
          ? SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 195, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            inputInfo(Icons.person, "Name", "Input Your Name",
                                _nameController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }),
                            inputInfo(
                                Icons.phone,
                                "Phone No.",
                                "Input Your Phone Number",
                                _phoneController, (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 10) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            }),
                            inputInfo(Icons.email_rounded, "E-Mail",
                                "Input Your E-Mail", _emailController, (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            }),
                            inputInfo(
                                Icons.domain,
                                "Address",
                                "Input Your Address",
                                _addressController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            }),
                            inputInfo(Icons.location_city_outlined, "City",
                                "Input Your City", _cityController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            }),
                            inputInfo(Icons.location_city, "ZipCode",
                                "Input Your Zipcode", _zipController, (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 5) {
                                return 'Please enter a valid 5-digit zipcode';
                              }
                              return null;
                            }),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a success toast
                                      MotionToast.success(
                                        description: const Text(
                                          'Your account has been successfully created!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ).show(context);
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
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 27,
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
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
