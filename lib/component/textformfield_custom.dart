import 'package:flutter/material.dart';

class TextformfieldCustom extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText; //hide text?
  final iconch;
  final validator;
  final keyboardtype;

  const TextformfieldCustom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.iconch,
    required this.validator, this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardtype,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            // icon: IconButton(onPressed: onPressed, icon: icon)
            labelText: labelText,
            suffixIcon: iconch,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12)

          ),
        ));
  }
}
