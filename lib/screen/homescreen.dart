import 'dart:convert';

import 'package:ecommerceapp_f/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> productList=[];

  Future<List<ProductModel>> product() async{
  var respones =await http.get(Uri.parse('https://ecom.liberalsoft.net/api/products'));


  if(respones.statusCode == 200){
    var data = jsonDecode(respones.body);
    for ( var i in data){
        ProductModel productModel = ProductModel(
            name: i['name'],
            uid: i['uid'],
            description: i['description'],
            discount: i['discount'],
            price: i['price'],
            stock: i['stock'],
            productImage1: i['product_image1'],
            overDiscount: i['over_discount']);
        productList.add(productModel);
    }



  }
  return productList;
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: product(),
        builder: (context,snapshot){
          if(snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          }else{
            List<ProductModel> product = snapshot.data!;

            return ListView.builder(
                itemCount: product.length,
                itemBuilder: (context,index){
                  ProductModel productData = product[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Image.network(
                          productData.productImage1.toString(),
                          errorBuilder: (context,error,stack){
                            return const Icon(Icons.error,color: Colors.red,);
                          },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(productData.name.toString()),
                        subtitle: Text(productData.price.toString()),
                      ),
                    ),
                  );
                });
          }
        },

      ),
    );
  }
}
