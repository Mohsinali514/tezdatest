import 'package:flutter_bloc_fakestoreapi/data/models/category.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}
