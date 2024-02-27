
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart'as http;
import 'package:velocity_x/velocity_x.dart';
import '../../util/textfield.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  static var clinet = http.Client();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
   bool showSpinner = false;
  // String? imagedata=null;
   String? imagename=null;
  String? imageSpath=null;
  String dropdownValue ="None";
  final _formKey= GlobalKey<FormState>();
  final _passformKey= GlobalKey<FormState>();
  final ImagePicker  _picker =ImagePicker();
  File? _image;
 XFile? pickedImage;

  Future<void> _openImagePicker() async {
    try {
       pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage!.path);
        imagename = pickedImage!.path.split('/').last; //image name
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void>register(String email,String phone,String password,String fName,String lName,String gender)async{
    print("Start");
    setState(() {
      showSpinner = true;
    });
    try{
      var headers = {
        'Authorization':
        'X-CSRFTOKEN ' "F5qI0IL16xB5qsKlfXiN9WPDkPur0eu42bCXoonSqDnV7c2YOize3mgcpnaXAgIl",
      };
      // your endpoint and request method
      var request = http.MultipartRequest(
          'POST',
          Uri.parse("https://ecom.liberalsoft.net/api/customer/registration"));

      request.fields
          .addAll({"email": email,
        "phone": phone,
        "password": password,
        "first_name": fName,
        "last_name": lName,
        "gender": gender});
      request.files.add(await http.MultipartFile.fromPath(
          'customer_image', pickedImage!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if(response != null){

        setState(() {
          showSpinner=false;
        });
        print('Data Uploaded');
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
          title: const Text("Customer Registration"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(

            children: [
              TextFieldCustom(txt: "First Name", controllers:f_nameController, formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Last Name", controllers:l_nameController,formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Phone Number", controllers:phoneController,formKey: _formKey,),
              const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButtonFormField(
                hint: const Text("Selected gender"),
                value: dropdownValue,
                icon:const Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
                onChanged: (String ? Value){
                  setState(() {
                    dropdownValue = Value!;
                  });

                },
                decoration: const InputDecoration(
                    labelText: 'Mode',
                    border: OutlineInputBorder()

                ),
                items:const [
                  DropdownMenuItem(
                      value: "Male",
                      child: Text('Male')),
                  DropdownMenuItem(
                      value: "Female",
                      child: Text('Female')),
                  DropdownMenuItem(
                      value: "None",
                      child: Text('None')),
                ]
          ),
            ),


              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Email", controllers:emailController,formKey: _formKey,),
              const SizedBox(height: 10,),
              TextFieldCustom(txt: "Password", controllers:passwordController,formKey: _formKey,),
              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    _openImagePicker();
                  }, child: "Pick File".text.make()),
                  const SizedBox(width: 10,),
                  (pickedImage == null)? const Text('Image choose yet!'):Expanded(child: imagename!.text.make()),


                ],
              ),
              GestureDetector(
                onTap: (){
                  print(dropdownValue.toUpperCase());
                 setState(() {
                   register(emailController.text.toString(),phoneController.text.toString(),
                       passwordController.text.toString(), f_nameController.text.toString(),
                       l_nameController.text.toString(),dropdownValue.toUpperCase());
                 });

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
