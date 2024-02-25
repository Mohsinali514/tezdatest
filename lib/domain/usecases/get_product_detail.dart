import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository productRepository;
  GetProductDetail(this.productRepository);
  Future<Either<ServerFailure, ProductEntity>> call(int id) async {
    return await productRepository.getProductDetail(id);
  }
}
