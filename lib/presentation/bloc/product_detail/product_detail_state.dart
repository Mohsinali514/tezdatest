part of 'product_detail_bloc.dart';

abstract class ProductDetailState {}

class ProducDetailtInitial extends ProductDetailState {}

class ProducDetailtLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductEntity product;
  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductDetailState {
  final String message;
  ProductDetailError(this.message);
}
