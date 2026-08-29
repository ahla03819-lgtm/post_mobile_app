import 'package:flutter/material.dart';

class InputFormCustom extends StatelessWidget {
  String? hintText, labelText;
  TextEditingController? controller;
  bool obscureText;
  TextInputType? keyboardType;
  InputFormCustom({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.cyan),
          ),
          hintText: hintText ?? "",
          labelText: labelText ?? "",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.cyan),
          ),
        ),
      ),
    );
  }
}
