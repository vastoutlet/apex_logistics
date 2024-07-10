import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultForm extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? icon;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final String? hintText;
  final double borderWidth;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String?)? onSaved;
  final String? label;
  final bool readOnly;
  final Widget? suffixIcon;

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
    this.inputFormatter,
    this.onSaved,
    this.label,
    this.readOnly = false,
    this.suffixIcon = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      controller: controller,
      style: const TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        // border: InputBorder.none,
        labelText: label,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
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
