import 'package:flutter_bloc_fakestoreapi/core/networking/http_service.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/category_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/category_data_source_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/product_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/product_data_source_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/auth_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/category_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/product_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/user_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/category_repository.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/product_repository.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_categories.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_product_detail.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_products.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_user_detail.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;
void init() {
  //datasource
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton<HttpService>(() => HttpService(getIt()));
  getIt
      .registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(getIt()));
  getIt.registerLazySingleton<CategoryDataSource>(
      () => CategoryDataSourceImpl(getIt()));

  //repo
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(getIt()));

  //usecase
  getIt.registerLazySingleton(() => UserDetail(getIt()));
  getIt.registerLazySingleton(() => GetProducts(getIt()));
  getIt.registerLazySingleton(() => GetProductDetail(getIt()));
  getIt.registerLazySingleton(() => GetCategories(getIt()));

  //bloc
  getIt.registerFactory(() => AuthBloc(getIt()));
  getIt.registerFactory(() => UserDetailBloc(userDetail: getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
  getIt.registerFactory(() => ProductDetailBloc(getIt()));
  getIt.registerFactory(() => ProductSearchBloc(getIt()));
  getIt.registerFactory(() => CategoryBloc(getIt()));
}
