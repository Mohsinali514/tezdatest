import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_rating.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ProductEntity product;
  const ProductCard({super.key, this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'product-${product.id}',
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () => context.goNamed('product', extra: product),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                Center(
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 3,
                    imageUrl: product.images.first,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/noimage.jpg'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            verticalSpace(5),
                            Text(
                              "USD ${product.price}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        productRating(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
