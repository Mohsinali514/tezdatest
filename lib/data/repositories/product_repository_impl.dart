import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/product_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;
  ProductRepositoryImpl(this.productDataSource);
  @override
  Future<Either<ServerFailure, List<ProductEntity>?>> getProducts(
      String? filter) async {
    try {
      final List<ProductModel> productModel =
          await productDataSource.getProducts(filter);
      final List<ProductEntity> products =
          productModel.map((product) => product.toEntity()).toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, ProductEntity>> getProductDetail(int id) async {
    try {
      final ProductModel productModel =
          await productDataSource.getProductDetail(id);
      final ProductEntity product = productModel.toEntity();
      return Right(product);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
