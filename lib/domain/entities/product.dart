import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final int price;
  final String description;
  final CategoryEntity category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  const ProductEntity(
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  );

  @override
  List<Object?> get props =>
      [id, title, price, description, category, images, creationAt, updatedAt];
}
