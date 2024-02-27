import 'dart:io';

import 'package:ecommerceapp_f/screen/vendor/vendorloginscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart'as http;

import '../../util/textfield.dart';

class VendorRegister extends StatefulWidget {
  const VendorRegister({super.key});

  @override
  State<VendorRegister> createState() => _VendorRegisterState();
}

class _VendorRegisterState extends State<VendorRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController companynameController = TextEditingController();
  bool showSpinner = false;
  String? imagename = null;
  String? logoname = null;
  final _formKey= GlobalKey<FormState>();
  final _passformKey= GlobalKey<FormState>();
  final ImagePicker  _picker =ImagePicker();
  XFile? pickedImage;
  XFile? logoImage;

  Future<void> vendorImagePicker() async {
    try {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          File? _image = File(pickedImage!.path);
          imagename = pickedImage!.path.split('/').last; //image name
        });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> logoImagePicker() async {
    try {
      logoImage = await _picker.pickImage(source: ImageSource.gallery);
      if (logoImage != null) {
        setState(() {
          File? _imagelogo = File(logoImage!.path);
          logoname = logoImage!.path.split('/').last; //image name
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void>register(String email,String phone,String password,String fName,String lName,String nid,String company_name, )async{
    print("Start");
    setState(() {
      showSpinner = true;
    });
    try{
      var headers = {
        'Authorization':
        'X-CSRFTOKEN ' "rI2lWzbMsvArVgpSvYiWQBGGg2OndvbHS0PZH22annEA0jD5cC1wVc9OXO4KSDVz",
      };
      // your endpoint and request method
      var request = http.MultipartRequest(
          'POST',
          Uri.parse("https://ecom.liberalsoft.net/api/vendor/registration"));

      request.fields
       .addAll({
        "email": email,
        "phone": phone,
        "password": password,
        "first_name": fName,
        "last_name": lName,
        "nid": nid,
        "company_name":company_name,
      });
      request.files.add(await http.MultipartFile.fromPath(
          'logo', logoImage!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'vendor_pic', pickedImage!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if(response != null){

        setState(() {
          showSpinner=false;
        });
        print('Data Uploaded');
        Get.to(()=>const VendorLoginScreen());
      }else{
        print('data failed');
        setState(() {
          showSpinner=false;
        });
      }
    }catch(e){
      print(e);
    }


  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        
        appBar: AppBar(
          title: const Text("Vendor Registration"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(

            children: [
              TextFieldCustom(txt: "First Name", controllers:f_nameController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Last Name", controllers:l_nameController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Phone Number", controllers:phoneController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Nid", controllers:nidController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Company name", controllers:companynameController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Email", controllers:emailController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Password", controllers:passwordController, formKey: _formKey, ),
              const SizedBox(height: 10,),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(onPressed: (){
                      vendorImagePicker();
                    }, child: "Vendor Pic".text.make()),
                  ),
                  const SizedBox(width: 10,),
                  (pickedImage == null)? const Text('Image choose yet!'):Expanded(child: imagename!.text.make()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(onPressed: (){
                      logoImagePicker();
                    }, child: "Logo".text.make()),
                  ),
                  const SizedBox(width: 10,),
                  (logoImage == null)? const Text('Image choose yet!'):Expanded(child: logoname!.text.make()),

                ],
              ),
              GestureDetector(
                onTap: (){
                  register(emailController.text.toString(),
                      phoneController.text.toString(),
                      passwordController.text.toString(),
                      f_nameController.text.toString(),
                      l_nameController.text.toString(),
                      nidController.text.toString(),
                      companynameController.text.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Text("Sing In")),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
