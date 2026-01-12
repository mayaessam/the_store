import 'package:dio/dio.dart';
import 'package:the_store/featues/home/data/models/products_model.dart';
class ProductsService {
  final Dio dio = Dio();

  Future<List<Product>> getAllProducts() async {
    Response response =
    await dio.get('https://fakestoreapi.com/products');

    List data = response.data;
    List<Product> products = data
        .map((item) => Product.fromJson(item))
        .toList();

    return products;
  }
}
