class MenuItemEntity {
  final DateTime createdAt;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String categoryId;
  final int stock;
  final String id;

  MenuItemEntity({
    required this.createdAt,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.stock,
    required this.id,
  });
}