import 'package:flutter/material.dart';
import 'package:the_store/featues/home/data/models/products_model.dart';

import '../../../core/utils/app_fonts.dart';
import '../../cart/data/services/cart_manager.dart';
import '../data/services/product_details_service.dart';

class ProductDetails extends StatelessWidget {
   ProductDetails({super.key, required this.productId});
final int productId;

final ApiProductDetailsServices apiProductDetailsServices=ApiProductDetailsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back))
      ),
      body:FutureBuilder<Product>(future: apiProductDetailsServices.getProductDetails(productId),
          builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return const Center(child: Text('Error loading products'));
        }
        final product=snapshot.data!;
        return Card(
          child:Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.image
                    ,width: double.infinity,
                  height: 170,
                    ),
                Row(
                  children: [
                    Text(product.category,style: AppTextStyles.largeBold,),
                    IconButton(onPressed: (){
                      CartManager.add(product);
                    }, icon: Icon(Icons.add))

                  ],
                ),
                Text(product.title,style: AppTextStyles.mediumBold,),
                Text('\$${product.price}',style: AppTextStyles.mediumRegular),

              Text(product.description , maxLines: 6,
                  overflow: TextOverflow.ellipsis,style: AppTextStyles.mediumRegular),


              ],
            ),
          ) ,
        );
          })
    );
  }
}
