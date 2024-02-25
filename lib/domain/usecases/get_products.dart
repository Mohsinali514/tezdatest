import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository productRepository;
  GetProducts(this.productRepository);
  Future<Either<ServerFailure, List<ProductEntity>?>> call(
      String? filter) async {
    return await productRepository.getProducts(filter);
  }
}
