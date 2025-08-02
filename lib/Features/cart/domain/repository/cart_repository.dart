import '../../../../core/error/result.dart';

abstract class CartRepository {

  Future<Result> addToCart({required String menuItemId});
  Future<Result> removeFromCart({required String menuItemId});
  Future<Result> clearCart({required List<String> menuItemIds });
  Future<Result> updateQuantity({required String menuItemId, required int quantity});
  Future<Result> fetchCartItems();
  Future<Result> fetchCartItemsDetails({required List<String> menuItemIds});

}