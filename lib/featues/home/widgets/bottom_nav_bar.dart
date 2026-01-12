import 'package:flutter/material.dart';
import 'package:the_store/featues/add_product/presentatiion/add_product_scren.dart';
import 'package:the_store/featues/cart/presentatiion/cart_screen.dart';
import 'package:the_store/featues/home/presentation/home_screen.dart';
import 'package:the_store/featues/profile/profile_screen.dart';

class MainBottomNav extends StatelessWidget {
  final int currentIndex;

  const MainBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AddProductScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CartScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(userId: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      backgroundColor: Colors.white, // اللون ثابت
      elevation: 8, // يعطي ظل
      selectedItemColor: Colors.deepPurple, // اللون للـ selected icon
      unselectedItemColor: Colors.grey, // اللون للـ unselected icon
      type: BottomNavigationBarType.fixed, // ضروري لو أكثر من 3 عناصر
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
