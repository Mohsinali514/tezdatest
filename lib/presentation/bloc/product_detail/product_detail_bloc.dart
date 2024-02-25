import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_product_detail.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  GetProductDetail getProductDetail;

  ProductDetailBloc(this.getProductDetail) : super(ProducDetailtInitial()) {
    on<FetchProductDetail>((event, emit) async {
      emit(ProducDetailtLoading());
      final failureOrProduct = await getProductDetail(event.id);
      failureOrProduct.fold(
        (failure) => emit(ProductDetailError(failure.message)),
        (product) => emit(ProductDetailLoaded(product)),
      );
    });
  }
}
