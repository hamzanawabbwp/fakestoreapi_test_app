import '../product/product.dart';

class Cart {
  final Product? product;
  int quantity;
  Cart({
    required this.product,
    required this.quantity,
  });
}
