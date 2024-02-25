import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';

class NotFound extends StatelessWidget {
  final String message;
  const NotFound({super.key, this.message = 'Not Found'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error),
          verticalSpace(10),
          Text(
            message,
            style: const TextStyle(color: darkGrey),
          ),
        ],
      ),
    );
  }
}
