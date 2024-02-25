import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_categories.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;

  CategoryBloc(this.getCategories) : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());
      final failureOrCategory = await getCategories();
      failureOrCategory.fold(
        (failure) => emit(CategoryError(failure.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    });
  }
}
