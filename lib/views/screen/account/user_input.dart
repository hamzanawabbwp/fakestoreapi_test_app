import 'package:flutter/material.dart';

Widget inputInfo(IconData icon, String label, String hintText,
    TextEditingController controller, String? Function(String?)? validator) {
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
