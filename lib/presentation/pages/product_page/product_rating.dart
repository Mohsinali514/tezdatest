import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';

Widget productRating() => Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        Text(
          (Random().nextDouble() * 5).toStringAsFixed(1),
          style: const TextStyle(fontSize: 14),
        ),
        horizontalSpace(10),
        Text(
          "${Random().nextInt(100)} Reviews",
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
