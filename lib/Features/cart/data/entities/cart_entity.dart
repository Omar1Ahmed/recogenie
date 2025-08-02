class CartEntity {
  final String id;
  final String itemId;
  int quantity;
  final String userId;

  CartEntity({this.id ='', required this.itemId,required this.quantity, required this.userId});
}