part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProduct extends ProductEvent {
  final String filter;
  FetchProduct(this.filter);
}

class FetchProductDetail extends ProductEvent {}
