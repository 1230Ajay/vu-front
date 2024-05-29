import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/colors.dart';

Widget appTextField(String hintText , {void Function(String value)? onChange, required TextEditingController controller}){
  return TextField(
    onChanged: (value)=>onChange!(value),
    keyboardType: TextInputType.multiline,
    controller: controller,
    maxLines: null,
    decoration: InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      hintStyle: const TextStyle(color: AppColors.primaryFourElementText),
    ),
    autocorrect: false,
    style: TextStyle(
        color: Colors.black, fontFamily: "Avenir", fontSize: 12.sp),
  );
}