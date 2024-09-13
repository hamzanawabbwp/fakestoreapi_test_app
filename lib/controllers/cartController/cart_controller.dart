import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/cart/cart.dart';
import '../../../models/product/product.dart';
import '../../../services/cart/cart.dart';

class CartController extends ChangeNotifier {
  final CartService _cartService;

  CartController(this._cartService);

  List<Cart> get cartItems => [..._cartService.listProducts];

  bool isOnCart(Product product) {
    return _cartService.isOnCart(product);
  }

  void addToCart(Product product) {
    final existingCartItem = cartItems.firstWhere(
      (item) => item.product == product,
      orElse: () => Cart(product: product, quantity: 0),
    );

    if (existingCartItem.quantity == 0) {
      _cartService.addProduct(Cart(product: product, quantity: 1));
    } else {
      updateQuantity(product, existingCartItem.quantity + 1);
    }
    notifyListeners(); // Notify listeners about state changes
  }

  void removeFromCart(Product product) {
    final item = cartItems.firstWhere((item) => item.product == product);
    _cartService.removeProduct(item);
    notifyListeners(); // Notify listeners about state changes
  }

  Future<void> updateQuantity(Product product, int quantity) async {
    final index = cartItems.indexWhere((item) => item.product == product);
    if (index != -1) {
      if (quantity > 0) {
        _cartService.listProducts[index].quantity = quantity;

        final productsList = _cartService.listProducts.map((item) {
          return {
            'productId': item.product!.id,
            'quantity': item.quantity,
          };
        }).toList();

        // Update cart quantity via API
        final response = await http.put(
          Uri.parse('https://fakestoreapi.com/carts/7'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': 3,
            'date': '2019-12-10',
            'products': productsList,
          }),
        );

        if (response.statusCode == 200) {
          print('Cart updated successfully');
        } else {
          print('Failed to update cart');
        }
      } else {
        _cartService.removeProduct(_cartService.listProducts[index]);
      }
      notifyListeners(); // Notify listeners about state changes
    }
  }
}
