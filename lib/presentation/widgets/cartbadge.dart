import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/cart/cart_bloc.dart';
import 'package:go_router/go_router.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.goNamed('cart'),
          child: Stack(
            children: [
              const SizedBox(
                width: 40,
                child: Center(
                    child: Icon(Icons.shopping_cart_outlined,
                        color: Colors.black)),
              ),
              state is CartLoaded
                  ? state.cart.products.isEmpty
                      ? const SizedBox()
                      : Positioned(
                          top: 4,
                          right: 1,
                          child: badges.Badge(
                            badgeContent: Text(
                              "${state.cart.products.length}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: state.cart.products.length > 10
                                      ? 10
                                      : 12),
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
