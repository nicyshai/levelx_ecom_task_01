import 'package:ecom_test2/views/splashView.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/cartcontroller.dart';

import 'controllers/productcontroller.dart';
import 'controllers/wishlistcontroller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Productcontroller()..fetchproducts()),
        ChangeNotifierProvider(create: (_) => Wishlistcontroller()),
        ChangeNotifierProvider(create: (_) => Cartcontroller()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const Splashview(),
    );
  }
}
