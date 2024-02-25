import 'package:flutter_bloc_fakestoreapi/data/models/product.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts(String? filter);
  Future<ProductModel> getProductDetail(int id);
}
