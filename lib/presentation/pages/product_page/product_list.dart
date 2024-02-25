import 'package:flutter/material.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_card.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/notfound.dart';

class ProductList extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2;
    return products.isEmpty
        ? const NotFound(message: 'Product Not Found')
        : GridView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemBuilder: (context, i) {
              return ProductCard(product: products[i]);
            },
          );
  }
}
