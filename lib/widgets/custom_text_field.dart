import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  CustomTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon ??
              (isPassword
                  ? IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: () {
                  // Logic to toggle password visibility
                },
              )
                  : null),
        ),
      ),
    );
  }
}
