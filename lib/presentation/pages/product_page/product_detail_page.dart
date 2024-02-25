import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_rating.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/cartBadge.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mybutton.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: CartBadge(),
            ),
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14.0),
                children: [
                  Hero(
                    tag: 'product-${product.id}',
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: CachedNetworkImage(
                        imageUrl: product.images.first,
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/noimage.jpg'),
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "USD ${product.price}",
                        style: const TextStyle(
                          color: lightGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.heart,
                        color: lightGreen,
                      )
                    ],
                  ),
                  verticalSpace(8),
                  Text(product.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  verticalSpace(8),
                  productRating(),
                  verticalSpace(10),
                  Text(product.description),
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              width: double.infinity,
              height: 50,
              child: MyButton(
                child: const Text('Add to Cart'),
                ontap: () => context.read<CartBloc>()..add(CartAdd(product)),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
