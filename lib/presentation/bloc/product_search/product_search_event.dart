part of 'product_search_bloc.dart';

abstract class ProductSearchEvent {}

class FetchProductSearch extends ProductSearchEvent {
  final String query;
  FetchProductSearch(this.query);
}
