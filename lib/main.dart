import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/di.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/cart_page/cart_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/home_page/home_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/login_page/login_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_detail_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/profile_page/profile_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/search_page/search_page.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/signup_page/signup_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(AuthInitialCheckRequested()),
        ),
        BlocProvider(
            create: (context) =>
                getIt<UserDetailBloc>()..add(FetchUserDetail())),
        BlocProvider(
            create: (context) => getIt<ProductBloc>()..add(FetchProduct(''))),
        BlocProvider(create: (context) => getIt<ProductDetailBloc>()),
        BlocProvider(create: (context) => getIt<ProductSearchBloc>()),
        BlocProvider(
            create: (context) => getIt<CategoryBloc>()..add(FetchCategories())),
        BlocProvider(create: (context) => CartBloc()..add(CartStart())),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUserAuthenticated) {
            router.goNamed('home');
          } else if (state is AuthUserUnauthenticated) {
            router.goNamed('login');
          } else if (state is AuthInitialCheckRequested) {
            // Handle initial check, if needed
          } else if (state is AuthUserSignupRequested) {
            router.goNamed('signup');
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );
  }

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) =>  const SignupPage(),
      ),

      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
              path: 'product',
              name: 'product',
              builder: (context, state) {
                ProductEntity product = state.extra as ProductEntity;
                return ProductDetailPage(product: product);
              }),
          GoRoute(
            path: 'search',
            name: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: 'cart',
            name: 'cart',
            builder: (context, state) => const CartPage(),
          ),
        ],
      ),
    ],
    initialLocation: '/login',
    debugLogDiagnostics: false,
    routerNeglect: true,
  );
}
