import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/category_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource categoryDataSource;
  CategoryRepositoryImpl(this.categoryDataSource);
  @override
  Future<Either<ServerFailure, List<CategoryEntity>?>> getCategories() async {
    try {
      final List<CategoryModel> categoryModel =
          await categoryDataSource.getCategories();
      final List<CategoryEntity> categories =
          categoryModel.map((category) => category.toEntity()).toList();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
