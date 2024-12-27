import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,this.label,this.onChanged,this.obscureText =false});
    String? label;
    Function(String)? onChanged;
    bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data){
       if(data!.isEmpty) {
         return 'not null';
       }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(label!,style: TextStyle(color: Colors.white,),),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
