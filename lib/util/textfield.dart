import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextEditingController controllers = TextEditingController();
  String txt ;
  GlobalKey<FormState> formKey ;
   TextFieldCustom({super.key,required this.txt,required this.controllers,required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
      child: TextFormField(
        maxLines: 1,
        controller: controllers,
        decoration: InputDecoration(
          hintText: txt,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter some text';
          }else{
            return null;
          }
        },
      ),
    );
  }
}
