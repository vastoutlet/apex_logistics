import 'package:flutter/material.dart';

class DefaultForm extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const DefaultForm({
    this.keyboardType = TextInputType.name,
    this.validator,
    this.controller,
    super.key,
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
        prefixIcon: Icon(
          Icons.abc,
        ),
      ),
    );
  }
}
