import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final double borderRadius;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 12.0,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText ? _passwordVisible : false,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        floatingLabelStyle: const TextStyle(
          color: lightGreen,
          fontSize: 18,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
                child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: darkGrey,
                ),
              )
            : widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: lightGreen, width: 2),
        ),
      ),
    );
  }
}
