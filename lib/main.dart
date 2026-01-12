import 'package:flutter/material.dart';
import 'package:the_store/featues/cart/presentatiion/cart_screen.dart';
import 'featues/home/presentation/home_screen.dart';
import 'featues/login/presentaton/login_screen.dart';
import 'featues/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  HomeScreen()
    );
  }
}
