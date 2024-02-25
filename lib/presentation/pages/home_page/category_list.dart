import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, i) {
            return Material(
              borderRadius: BorderRadius.circular(30),
              color: categories[i].isSelected ? lightGreen : Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if (!categories[i].isSelected && state is! ProductLoading) {
                for (var element in categories) {
                  element.isSelected = false;
                }
                categories[i].isSelected = true;
                context.read<ProductBloc>().add(FetchProduct(
                    'categoryId=${i == 0 ? '' : categories[i].id}'));
              }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    categories[i].name,
                    style: TextStyle(
                      color: categories[i].isSelected ? Colors.white : darkGrey,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
