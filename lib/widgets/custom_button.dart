import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.deepOrange,
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
