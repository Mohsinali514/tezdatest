import 'package:flutter/material.dart';

class MySearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  const MySearchTextField(
      {super.key, required this.controller, required this.onChanged});

  @override
  State<MySearchTextField> createState() => _MySearchTextFieldState();
}

class _MySearchTextFieldState extends State<MySearchTextField> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
        hintText: 'Product Name',
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        suffixIconColor: Colors.black,
        suffixIcon: !visibility && widget.controller.text.isEmpty
            ? null
            : GestureDetector(
                onTap: () {
                  widget.controller.clear();
                  visibility = false;
                  setState(() {});
                },
                child: const Icon(Icons.close, size: 24),
              ),
      ),
    );
  }
}
