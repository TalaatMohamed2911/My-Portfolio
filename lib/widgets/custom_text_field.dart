import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    this.hintText,
  });
  final TextEditingController? controller;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: CustomColor.scaffoldBg),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        border: getInputBorder,
        focusedBorder: getInputBorder,
        enabledBorder: getInputBorder,
        hintText: hintText,
        hintStyle: TextStyle(color: CustomColor.hintDark),
      ),
    );
  }

  OutlineInputBorder get getInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide.none,
    );
  }
}
