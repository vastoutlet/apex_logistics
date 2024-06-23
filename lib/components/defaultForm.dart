import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultForm extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData? icon;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final String? hintText;
  final double borderWidth;

  const DefaultForm({
    this.keyboardType = TextInputType.name,
    this.validator,
    this.controller,
    this.icon,
    this.borderColor = Constants.whiteNormal,
    this.focusedBorderColor = Constants.whiteNormal,
    this.fillColor = Constants.whiteNormal,
    this.hintText,
    super.key,
    this.borderWidth = 20,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        fillColor: fillColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderWidth),
          borderSide: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderWidth),
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
      ),
    );
  }
}
