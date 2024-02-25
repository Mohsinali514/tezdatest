import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      final failureOrProduct = await getProducts(event.filter);
      failureOrProduct.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}
