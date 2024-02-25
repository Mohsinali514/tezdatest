import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;

  bool isSelected = false;

  CategoryModel(this.id, this.name, this.image, this.creationAt, this.updatedAt,
      this.isSelected);

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      map['id'],
      map['name'],
      map['image'],
      /*map['creationAt']*/'',
      /*map['updatedAt']*/'',
      false,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id, name, image, creationAt, updatedAt, isSelected);
  }
}
