import 'package:flutter/material.dart';
import 'package:smart_rabbit_second_app/View/On_Boarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).primaryColor),
        useMaterial3: true,
        primaryColor: const Color(0xff0A3B9A),
      ),
      home:const SplashScreen(),
    );
  }
}
