import 'package:flutter/material.dart';
import '../../../views/screen/account/account.dart'; // Import the Account screen
import '../../../views/screen/cart/cart.dart';
import '../home_product/home_products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pagesIndex = 0;

  final List<Widget> _pages = [
    const Products(),
    const CartView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                iconSize: 30,
                color: Colors.white,
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Account(),
                    ),
                  );
                },
                tooltip: 'Account',
              ),
            );
          },
        ),
        title: Title(
          color: Colors.grey,
          child: const Text(
            "Test App",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          _pages[_pagesIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pagesIndex,
        onTap: (index) {
          setState(() {
            _pagesIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_sharp,
              color: Colors.white,
              size: 30,
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
