import 'package:chairy_app/core/helper/Hive/HiveTypesHelper.dart';
import 'package:hive/hive.dart';

import '../../../../Features/categories/domain/entity/CategoryEntity.dart';

part 'category_hive_model.g.dart';

@HiveType(typeId: CategoriesType.typeId, adapterName: CategoriesType.adapterName)
class CategoryHiveModel extends HiveObject {

  @HiveField(CategoriesType.IdFieldId)
  int id;

  @HiveField(CategoriesType.titleFieldId)
  String title;

  @HiveField(CategoriesType.descriptionFieldId)
  String description;

  @HiveField(CategoriesType.imageFieldId)
  String image;

  @HiveField(CategoriesType.statusFieldId)
  int status;

  @HiveField(CategoriesType.createdAtFieldId)
  DateTime createdAt;

  @HiveField(CategoriesType.updatedAtFieldId)
  DateTime updatedAt;

  CategoryHiveModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryEntity toEntity() => CategoryEntity(
    id: id, // You may need to store id too if needed
    title: title,
    description: description,
    image: image,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory CategoryHiveModel.fromEntity(CategoryEntity entity) => CategoryHiveModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    image: entity.image,
    status: entity.status,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );
}

