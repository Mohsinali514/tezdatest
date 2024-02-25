import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_products.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  GetProducts getProducts;
  ProductSearchBloc(this.getProducts) : super(ProductSearchInitial()) {
    on<FetchProductSearch>((event, emit) async {
      emit(ProductSearchLoading());
      final failureOrProduct = await getProducts(event.query);
      failureOrProduct.fold(
        (failure) => emit(ProductSearchError(failure.message)),
        (products) => emit(ProductSearchLoaded(products ?? [])),
      );
    });
  }
}
