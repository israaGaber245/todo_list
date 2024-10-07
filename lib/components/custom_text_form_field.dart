import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/MyTheme.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyBoardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool isPassword;
  CustomTextFormField({required this.label,
    this.keyBoardType=TextInputType.text,
    required this.controller,
    required this.validator,
    this.isPassword=false
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(label,style: TextStyle(color: MyTheme.primaryLight),),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 3,
              color: MyTheme.primaryLight
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 3,
                  color: MyTheme.primaryLight
              )
          ),
        ),
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
        obscureText: isPassword,
      ),
    );
  }
}
