import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/cart.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStart>(_onCartStart);
    on<CartAdd>(_onCartAdd);
    on<CartDelete>(_onCartDelete);
    on<CartDeleteAll>(_onCartDeleteAll);
    on<CartEmpty>(_onCartEmpty);
  }

  void _onCartEmpty(
    CartEmpty event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      emit(const CartLoaded(cart: Cart()));
    }
  }

  void _onCartStart(
    CartStart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(const CartLoaded(cart: Cart()));
  }

  void _onCartAdd(
    CartAdd event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      emit(CartLoaded(
        cart: state.cart.copyWith(
          product: List.from(state.cart.products)..add(event.product),
        ),
      ));
    }
  }

  void _onCartDelete(
    CartDelete event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      emit(CartLoaded(
        cart: state.cart.copyWith(
          product: List.from(state.cart.products)..remove(event.product),
        ),
      ));
    }
  }

  void _onCartDeleteAll(
    CartDeleteAll event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      emit(
        CartLoaded(
          cart: state.cart.copyWith(
            product: List.from(state.cart.products)
              ..removeWhere(
                (product) => product == event.product,
              ),
          ),
        ),
      );
    }
  }
}
