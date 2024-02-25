import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback ontap;
  const MyButton({
    Key? key,
    required this.child,
    this.color = lightGreen,
    required this.ontap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(lightGreen),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      onPressed: ontap,
      child: child,
    );
  }
}
