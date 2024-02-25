import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<ServerFailure, List<ProductEntity>?>> getProducts(
      String? filter);
  Future<Either<ServerFailure, ProductEntity>> getProductDetail(int id);
}
