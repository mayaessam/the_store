import 'package:flutter/material.dart';
import 'package:the_store/core/utils/app_fonts.dart';
import 'package:the_store/featues/home/data/services/product_services.dart';
import 'package:the_store/featues/home/data/models/products_model.dart';
import 'package:the_store/featues/home/widgets/bottom_nav_bar.dart';
import 'package:the_store/featues/product/presentation/product_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductsService apiService = ProductsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('product', style: AppTextStyles.mediumBold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<Product>>(
          future: apiService.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                  child: Text('Error loading products'));
            }

            final products = snapshot.data!;

            return GridView.builder(
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7, // شكل الكارت
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetails(productId: product.id),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.mediumBold,
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '\$${product.price}',
                            style:
                            AppTextStyles.mediumRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 0),
    );
  }
}
