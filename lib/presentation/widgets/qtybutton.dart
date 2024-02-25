import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';

class QtyButton extends StatelessWidget {
  final VoidCallback ontap;
  final IconData icon;
  const QtyButton({super.key, required this.ontap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: ontap,
      child: Container(
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(color: darkGrey),
            borderRadius: BorderRadius.circular(6)),
        child: Icon(
          icon,
          size: 18,
          color: darkGrey,
        ),
      ),
    );
  }
}
