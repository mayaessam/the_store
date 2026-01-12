import 'package:flutter/material.dart';
import '../../../core/utils/app_fonts.dart';
import '../../home/widgets/bottom_nav_bar.dart';

import '../data/services/cart_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    return CartManager.cartItems.fold(
        0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    final items = CartManager.cartItems;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart', style: AppTextStyles.mediumBold),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.network(
                          product.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.mediumBold,
                              ),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: AppTextStyles.mediumRegular,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          onPressed: () {
                            setState(() {
                              CartManager.remove(product);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Total price & checkout button
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.mediumBold.copyWith(
                      fontSize: 18, color: Colors.black87),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add checkout logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Checkout clicked!')),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 2),
    );
  }
}
