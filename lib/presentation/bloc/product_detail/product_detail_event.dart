part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {}

class FetchProductDetail extends ProductDetailEvent {
  final int id;
  FetchProductDetail(this.id);
}
