import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';

class Cart extends Equatable {
  final List<ProductEntity> products;

  const Cart({this.products = const <ProductEntity>[]});

  Cart copyWith({
    List<ProductEntity>? product,
  }) {
    return Cart(products: product ?? products);
  }

  @override
  List<Object?> get props => [products];

  Map itemQuantity(List<ProductEntity> products) {
    var quantity = {};
    for (var product in products) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    }

    return quantity;
  }

  int get subtotal =>
      products.fold(0, (total, current) => total + (current.price).toInt());
}
