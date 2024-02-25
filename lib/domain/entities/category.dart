import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;
  bool isSelected = false;

  CategoryEntity(this.id, this.name, this.image, this.creationAt,
      this.updatedAt, this.isSelected);

  @override
  List<Object?> get props =>
      [id, name, image, creationAt, updatedAt, isSelected];
}
