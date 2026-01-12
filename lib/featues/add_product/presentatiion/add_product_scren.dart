import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_store/core/utils/app_fonts.dart';
import 'package:the_store/featues/add_product/widgets/custom_textformfield_witth%20title.dart';

import '../../home/widgets/bottom_nav_bar.dart';

class AddProductScreen extends StatefulWidget {
   AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final Dio dio=Dio();
  bool isLoading=false;

  Future<void>addProduct()async{

    try{
      setState(() {
        isLoading=true;
      });
      final Response response=await dio.post('https://fakestoreapi.com/products',data:
      {
        "id": 0,
        "title": titleController.text,
        "price": priceController.text,
        "description": descriptionController.text,
        "category":categoryController.text,
        "image": "http://example.com"
      }
      );
      log('response$response');

      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('product added ')));
      log('product added ${response.data}');
      clear();
    }on DioException catch(e){
      log("error:$e");
      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error occured ')));
    }

  }

  void clear(){
    titleController.clear();
    descriptionController.clear();
    imageController.clear();
    categoryController.clear();
    priceController.clear();
  }
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('add product',style: AppTextStyles.mediumBold,),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
             CustomTextFormFieldWithTitle(fieldLabel: 'title',
            controller: titleController,
            hint: 'title'), SizedBox(height: 10,),
             CustomTextFormFieldWithTitle(fieldLabel: 'description',
            controller: descriptionController,
            hint: 'description'),SizedBox(height: 10,),
            CustomTextFormFieldWithTitle(fieldLabel: 'price',
                controller: priceController,
                hint: 'price'),SizedBox(height: 10,),
            CustomTextFormFieldWithTitle(fieldLabel: 'category',
                controller: categoryController,
                hint: 'category'),SizedBox(height:30 ,),
            ElevatedButton(onPressed: (){
              addProduct();
            }, child: Text('Add Product',style: AppTextStyles.mediumBold,))

          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 1),
    );
  }
}
