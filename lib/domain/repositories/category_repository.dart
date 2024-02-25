import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<ServerFailure, List<CategoryEntity>?>> getCategories();
}
