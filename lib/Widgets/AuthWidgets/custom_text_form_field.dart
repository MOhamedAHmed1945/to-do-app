// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    this.keyBoradType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  });
  String label;
  TextInputType keyBoradType;
  TextEditingController controller;
  MyValidator validator;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyThemeApp.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyThemeApp.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyThemeApp.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyThemeApp.primaryColor,
              width: 2,
            ),
          ),
        ),
        keyboardType: keyBoradType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}
