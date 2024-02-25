import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/networking/http_service.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/product_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/product.dart';

class ProductDataSourceImpl implements ProductDataSource {
  final HttpService client;
  ProductDataSourceImpl(this.client);
  @override
  Future<List<ProductModel>> getProducts(String? filter) async {
    final response = await client.get(endpoint: '/products/?$filter');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<ProductModel> products = (responseBody as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      return products;
    } else {
      return exceptionHandling(response);
    }
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    final response = await client.get(endpoint: '/products/$id');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final ProductModel product = ProductModel.fromJson(responseBody);
      return product;
    } else {
      return exceptionHandling(response);
    }
  }
}
