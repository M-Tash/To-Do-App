import 'package:flutter/material.dart';

import '../../config/theme/my_theme.dart';

typedef myValidator = String? Function(String?)?;

class CustomTextFormField extends StatefulWidget {
  String label;
  TextInputType keyboardType;
  TextEditingController controller;
  myValidator validator;
  bool? icon;
  bool? obscureText;

  @override
  CustomTextFormField({super.key, required this.label,
      this.keyboardType = TextInputType.text,
      required this.controller,
      required this.validator,
      this.icon = false,
      this.obscureText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordVisible = false;

  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.displaySmall,
      decoration: InputDecoration(
          suffixIcon: widget.icon != false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: MyTheme.primaryColor,
                  ),
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.primaryColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.redColor),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.redColor),
          ),
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelMedium),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText ?? !passwordVisible,
    );
  }
}
