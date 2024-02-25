import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/product_page/product_rating.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/cartBadge.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mysearchtextfield.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/notfound.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: CartBadge(),
            ),
          ],
          elevation: 0,
        ),
        body: BlocBuilder<ProductSearchBloc, ProductSearchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: MySearchTextField(
                      controller: searchController,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          context
                              .read<ProductSearchBloc>()
                              .add(FetchProductSearch('title=$value'));
                        });
                      },
                    ),
                  ),
                  verticalSpace(20),
                  Expanded(
                    child: state is ProductSearchLoaded
                        ? state.products.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.products.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  var product = state.products[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Hero(
                                      tag: 'product-${product.id}',
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () => context.goNamed('product',
                                            extra: product),
                                        child: Container(
                                          padding: const EdgeInsets.all(14.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 120,
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: product.images.first,
                                                height: 100,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/noimage.jpg'),
                                              ),
                                              horizontalSpace(20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              180,
                                                          child: Text(
                                                            product.title,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "USD ${product.price}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  productRating(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const NotFound(message: 'Product Not Found')
                        : state is ProductSearchError
                            ? Text(state.message)
                            : state is ProductSearchInitial
                                ? const Center(
                                    child: Text('Type product name...'))
                                : const Center(
                                    child: CircularProgressIndicator()),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
