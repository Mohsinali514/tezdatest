import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/home_page/category_list.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_list.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/cartBadge.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // context.read<CategoryBloc>().add(FetchCategories());
    // context.read<ProductBloc>().add(FetchProduct(''));
    // context.read<UserDetailBloc>().add(FetchUserDetail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, user) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: user is UserDetailLoaded
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        /*height: 220,*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => context.goNamed('profile'),
                                  child: const CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        /*user.userEntity.avatar*/'https://i.pravatar.cc'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/logo.png', scale: 1.5),
                                    horizontalSpace(4),
                                    const Text(
                                      'Shop IT',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () => context.goNamed('search'),
                                        child: const Icon(Icons.search)),
                                    horizontalSpace(15),
                                    const SizedBox(
                                        height: 50, child: CartBadge()),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(30),
                            Center(
                              child: Text(
                                'Hi, ${user.userEntity.name}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            verticalSpace(5),
                            const Text(
                              'What are you looking for today?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalSpace(10),
                            SizedBox(
                              height: 40,
                              child: BlocBuilder<CategoryBloc, CategoryState>(
                                builder: (context, state) {
                                  if (state is CategoryLoaded) {
                                    return CategoryList(
                                        categories: state.categories ?? []);
                                  } else if (state is CategoryError) {
                                    return Center(child: Text(state.message));
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoaded) {
                              return ProductList(
                                  products: state.products ?? []);
                            } else if (state is ProductError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
