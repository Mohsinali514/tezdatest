part of 'product_search_bloc.dart';

abstract class ProductSearchState {}

class ProductSearchInitial extends ProductSearchState {}

class ProductSearchLoading extends ProductSearchState {}

class ProductSearchLoaded extends ProductSearchState {
  List<ProductEntity> products;
  ProductSearchLoaded(this.products);
}

class ProductSearchError extends ProductSearchState {
  final String message;
  ProductSearchError(this.message);
}
