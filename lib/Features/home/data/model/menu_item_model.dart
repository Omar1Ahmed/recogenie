import 'package:recogenie/Features/home/data/entities/menu_item_entity.dart';

class MenuItemsModel {
  final List<MenuItem> menuItems;

  MenuItemsModel({
    required this.menuItems,
  });

  factory MenuItemsModel.fromJson(List<Map<String, dynamic>> str) =>
      MenuItemsModel(menuItems: List<MenuItem>.from(str.map((x) => MenuItem.fromJson(x))));


  List<MenuItemEntity> toEntities() => menuItems.map((e) => e.toEntity()).toList();
}

class MenuItem {
  final DateTime createdAt;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String categoryId;
  final int stock;
  final String id;

  MenuItem({
    required this.createdAt,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.stock,
    required this.id,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    imageUrl: json["image_url"],
    categoryId: json["category_id"],
    stock: json["stock"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "name": name,
    "price": price,
    "description": description,
    "image_url": imageUrl,
    "category_id": categoryId,
    "stock": stock,
    "id": id,
  };

  MenuItemEntity toEntity() => MenuItemEntity(createdAt: createdAt, name: name, price: price, description: description, imageUrl: imageUrl, categoryId: categoryId, stock: stock, id: id);
}
