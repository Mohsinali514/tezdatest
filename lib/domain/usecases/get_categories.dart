import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository categoryRepository;
  GetCategories(this.categoryRepository);
  Future<Either<ServerFailure, List<CategoryEntity>?>> call() async {
    return await categoryRepository.getCategories();
  }
}
