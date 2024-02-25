import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/networking/http_service.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/category_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/category.dart';

class CategoryDataSourceImpl implements CategoryDataSource {
  final HttpService client;
  CategoryDataSourceImpl(this.client);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(endpoint: '/products/categories');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<CategoryModel> categories = (responseBody as List)
          .map((category) => CategoryModel.fromJson({
        "id" : category,
        "name" : category,
        "image" : "https://i.pravatar.cc"
      }
      )
      ).toList();
      categories.insert(0, CategoryModel('-1', 'All', '', '', '', true));
      return categories;
    } else {
      return exceptionHandling(response);
    }
  }
}
