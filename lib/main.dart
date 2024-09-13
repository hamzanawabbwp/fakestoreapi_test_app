import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/cartController/cart_controller.dart';
import 'services/cart/cart.dart';
import 'utils/app_colors.dart';
import 'views/screen/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => {
            runApp(const TestApp()),
          });
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartController(CartService()),
        ),
      ],
      child: MaterialApp(
        home: const Home(),
        title: 'Test App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.grey[300],
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: secondaryColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
