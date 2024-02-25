import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mybutton.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/notfound.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/qtybutton.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Shopping Cart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              actions: [
                (state is CartLoaded && state.cart.products.isNotEmpty)
                    ? GestureDetector(
                        onTap: () => context.read<CartBloc>()..add(CartEmpty()),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 14.0),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
              elevation: 0,
            ),
            body: state is CartLoaded
                ? state.cart.products.isEmpty
                    ? const NotFound(message: 'Empty Cart')
                    : Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.cart
                                    .itemQuantity(state.cart.products)
                                    .keys
                                    .length,
                                itemBuilder: (context, i) {
                                  var product = state.cart
                                      .itemQuantity(state.cart.products)
                                      .keys
                                      .elementAt(i);
                                  return ListView(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(14.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: grey),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 120,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: product.images.first,
                                              height: 100,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                            horizontalSpace(20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(product.title),
                                                  Text("USD ${product.price}"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          QtyButton(
                                                            ontap: () => context
                                                                .read<
                                                                    CartBloc>()
                                                              ..add(CartDelete(
                                                                  product)),
                                                            icon: Icons.remove,
                                                          ),
                                                          horizontalSpace(10),
                                                          Text(
                                                              "${state.cart.itemQuantity(state.cart.products).entries.elementAt(i).value}"),
                                                          horizontalSpace(10),
                                                          QtyButton(
                                                            ontap: () =>
                                                                context.read<
                                                                    CartBloc>()
                                                                  ..add(CartAdd(
                                                                      product)),
                                                            icon: Icons.add,
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => context
                                                            .read<CartBloc>()
                                                          ..add(CartDeleteAll(
                                                              product)),
                                                        child: const Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          color: darkGrey,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total ${state.cart.itemQuantity(state.cart.products).keys.length} Items",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "USD ${numberFormat.format(state.cart.subtotal)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: MyButton(
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Process to Checkout'),
                                      Icon(Icons.arrow_forward_rounded)
                                    ],
                                  ),
                                ),
                                ontap: () => false,
                              ),
                            ),
                          ],
                        ),
                      )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
