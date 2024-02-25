part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStart extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartAdd extends CartEvent {
  final ProductEntity product;
  const CartAdd(this.product);

  @override
  List<Object> get props => [product];
}

class CartDelete extends CartEvent {
  final ProductEntity product;
  const CartDelete(this.product);
  @override
  List<Object> get props => [product];
}

class CartDeleteAll extends CartEvent {
  final ProductEntity product;
  const CartDeleteAll(this.product);
  @override
  List<Object> get props => [product];
}

class CartEmpty extends CartEvent {
  @override
  List<Object> get props => [];
}
