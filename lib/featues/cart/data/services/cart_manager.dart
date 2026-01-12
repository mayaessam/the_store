
import '../../../home/data/models/products_model.dart';

class CartManager {
  static List<Product> cartItems = [];

  static void add(Product product) {
    cartItems.add(product);
  }

  static void remove(Product product) {
    cartItems.remove(product);
  }
}
