import 'package:flutter/material.dart';

class PassTextsFields extends StatelessWidget {
  String emailText='';
  //TextEditingController emailController;
  bool passToggle ;
  VoidCallback onPress;
  GlobalKey<FormState> formKey ;


   PassTextsFields({required this.emailText,
     /*required this.emailController*/ required this.onPress,
     required this.passToggle,required this.formKey
     });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: SizedBox(
          width: 350,
          height: 50,
          // height: MediaQuery.of(context).size.height,
         // width: MediaQuery.of(context).size.width,
          child: TextFormField(
           // controller: emailController,
            obscureText: passToggle,
            decoration: InputDecoration(
              hintText: emailText,
              suffixIcon: InkWell(
                onTap: onPress,
                child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
              )
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter some text';
              }else if(value.length<8){
                return 'Min length is 8';
              }
              else{
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
