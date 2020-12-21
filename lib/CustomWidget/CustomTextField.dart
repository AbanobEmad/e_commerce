import 'package:flutter/material.dart';

import '../Constains.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function OnClick;
  String _ValidedMessage(String Hint){
    switch(Hint){
      case "Enter Your Name" :return 'Name is Empty';
      case "Enter Your E_mail" :return 'E_mail is Empty';
      case "Enter Your Password" :return 'Password is Empty';
    }
  }
  CustomTextField({
    @required this.hint,
    @required this.icon,
    @required this.OnClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: hint=="Enter Your Password"? true:false,
        validator: (value){
          if(value.isEmpty){
            return _ValidedMessage(hint);
          }
          return null;
        },
        onSaved: OnClick,
        cursorColor: KConstColor,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon:Icon(icon,color :KConstColor),
            filled: true,
            fillColor: KConstColor2,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
        ),
      ),
    );
  }
}