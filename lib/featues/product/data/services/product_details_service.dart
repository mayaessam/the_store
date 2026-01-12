import 'package:dio/dio.dart';
import 'package:the_store/featues/product/presentation/product_details.dart';

import '../../../home/data/models/products_model.dart';
class ApiProductDetailsServices {
  final Dio dio = Dio();

  Future<Product> getProductDetails(int id) async {
    Response response = await dio.get('https://fakestoreapi.com/products/$id');

    // response.data is a Map
    final product = Product.fromJson(response.data);

    return product; // return single Product, not a List
  }
}
