
import 'dart:convert';

import 'package:ecommerceapp_f/screen/customer/customerregister.dart';
import 'package:ecommerceapp_f/screen/homescreen.dart';
import 'package:ecommerceapp_f/screen/vendor/vendorloginscreen.dart';
import 'package:ecommerceapp_f/util/snackbar_helper.dart';
import 'package:ecommerceapp_f/util/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:velocity_x/velocity_x.dart';


class LoginScreen extends StatefulWidget {

   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static var client = http.Client();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //final _connect = GetConnect();
  final _formKey= GlobalKey<FormState>();
  final _passformKey= GlobalKey<FormState>();

  void login(String email,password) async{
  var response = await client.post(Uri.parse('https://ecom.liberalsoft.net/api/customer/login') ,
  body: {
    "email": email,
    "password": password
  });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var access = data['access'].toString();

      if(access != null){
        if (kDebugMode) {
          print("Access: ${data['access'].toString()}");
        }
        Get.to(()=>const HomeScreen());
      }
    }else{
      print("Error Data");
      showErrorMessage(context, message: "Your Email and Password are invalid.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           "Customer Login".text.bold.size(25).center.color(Colors.grey).underline.make(),
           const SizedBox(height: 20,),
           TextFieldCustom(txt: "Email", controllers:emailController, formKey: _formKey,),
           const SizedBox(height: 20,),
           TextFieldCustom(txt: "Password", controllers: passwordController, formKey: _formKey,),
           const SizedBox(height: 40,),
           GestureDetector(
             onTap: (){
                  setState(() {
                    login(emailController.text.toString(),passwordController.text.toString());
                  });
             },
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                 height: 50,
                 decoration: BoxDecoration(
                   color: Colors.blue,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: const Center(child: Text("LogIn")),
               ),
             ),
           ),

          "Create new account".text.size(16).center.color(Colors.green).make().onTap(() {
             Get.to(()=> const CustomerRegister());
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> const CustomerRegister()));
           }),
           const SizedBox(height: 10,),
           "Login vendor account".text.size(16).center.color(Colors.red).make().onTap(() {
             Get.to(()=> const VendorLoginScreen());
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> const CustomerRegister()));
           }),

         ],
      ),
    );
  }
}
