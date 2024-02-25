// import 'package:flutter_bloc_fakestoreapi/data/models/product.dart';
// import 'package:flutter_bloc_fakestoreapi/domain/entities/cart.dart';
// import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
// import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';

// class CartModel {
//   final int id;
//   final int idUser;
//   final ProductModel product;
//   final int qty;

//   CartModel(this.id, this.idUser, this.product, this.qty);
//   CartEntity toEntity() {
//     return CartEntity(
//       id: id,
//       idUser: idUser,
//       product: ProductEntity(
//           product.id,
//           product.title,
//           product.price,
//           product.description,
//           CategoryEntity(
//               product.category.id,
//               product.category.name,
//               product.category.image,
//               product.category.creationAt,
//               product.category.updatedAt,
//               product.category.isSelected),
//           product.images,
//           product.creationAt,
//           product.updatedAt),
//       qty: qty,
//     );
//   }
// }
