
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';
import 'package:recogenie/Features/cart/data/model/cart_model.dart';

import '../../../../../core/error/result.dart';
import '../../../../home/data/model/menu_item_model.dart';
import '../../../domain/repository/cart_repository.dart';

part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(CartInitial());

  int _totalItems = 0;
  double _totalPrice = 0;

  List<CartModel> _cartItems = [];

  List<MenuItem> cartItemsDetails= [];

  final ValueNotifier<int> totalItemsNotifier = ValueNotifier(0);

  final ValueNotifier<List<CartModel>> cartItemsNotifier = ValueNotifier([]);


  List<CartModel> get cartItems => _cartItems;

  void clearCartItems() {
    _cartItems.clear();
    cartItemsNotifier.value = List.from(_cartItems);
  }

  void addCartItem(CartModel item) {
    _cartItems.add(item);
    cartItemsNotifier.value = List.from(_cartItems);
  }

  void removeCartItem(CartModel item) {
    _cartItems.remove(item);
    cartItemsNotifier.value = List.from(_cartItems);
  }

  void addAllCartItems(List<CartModel> items) {
    _cartItems.addAll(items);
    cartItemsNotifier.value = List.from(_cartItems);
  }


  set cartItems(List<CartModel> value) {
    _cartItems = value;
    cartItemsNotifier.value = List.from(_cartItems);
  }

  set totalItems(int value) {
    _totalItems = value;
    totalItemsNotifier.value = value;
    emit(CartUpdated());
  }

  int get totalItems => _totalItems;


  double get totalPrice => _totalPrice;

  set totalPrice(double value) {
    _totalPrice = value;
    emit(CartUpdated());
  }

  Future<Result> fetchCartItems() async {

    final result = await _cartRepository.fetchCartItems(); // id , quantity , userId, itemId

    if(result is Success){

      cartItems.clear();
      addAllCartItems(result.data);
      totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);

    }

    return result;
  }

  fetchCartItemsDetails() async { // id , image , name , price, description


    emit(CartLoading());

    if(cartItems.isEmpty){
      emit(CartEmpty());
      return;
    }
    final result = await _cartRepository.fetchCartItemsDetails(menuItemIds: cartItems.map((e) => e.itemId).toList());

    if(result is Success){

      cartItemsDetails = [];
      cartItemsDetails.addAll(result.data);
      _totalPrice = cartItemsDetails.asMap().entries.map((e) => e.value.price * cartItems[e.key].quantity).reduce((a,b)=>a+b);
      emit(CartSuccess());

    }else if(result is FailureResult){

      emit(CartError(result.failure.message));
    }

  }


  Future<Result> addItems({required String itemId, required int quantity}) async {
    final result = await _cartRepository.addToCart(menuItemId: itemId);

    if(result is Success){

    addCartItem(CartModel(itemId: itemId, quantity: quantity));
    totalItems += quantity;

    }

    return result;


  }

  Future<Result> removeItems({required String itemId}) async {
    final result = await _cartRepository.removeFromCart(menuItemId: itemId);

    if(result is Success){

      removeCartItem(cartItems.firstWhere((e) => e.itemId == itemId));
      totalItems -= 1;

    }

    return result;
  }

  clearCart() async {
    emit(CartClearLoading());
    final result = await _cartRepository.clearCart(menuItemIds: cartItems.map((e) => e.itemId).toList());

    if(result is Success){

      clearCartItems();
      totalItems = 0;
      _totalPrice = 0 ;

      emit(CartEmpty());
    }else if(result is FailureResult){

      emit(CartError(result.failure.message));
    }

  }

  addQuantity(String itemId, double price) {
    cartItems.firstWhere((e) => e.itemId == itemId).quantity += 1;
    totalItems += 1;
    _totalPrice += price;
    emit(CartUpdated());
  }

  removeQuantity(String itemId, double price) {
    CartModel item = cartItems.firstWhere((e) => e.itemId == itemId);
    totalItems -= 1;
    _totalPrice -= price;

    if(item.quantity == 1){
      removeCartItem(cartItems.firstWhere((e) => e.itemId == itemId));
      cartItemsDetails.removeWhere((e) => e.id == itemId);
      if(cartItems.isEmpty){
        emit(CartEmpty());
        return;
      }
    }else{
    cartItems.firstWhere((e) => e.itemId == itemId).quantity -= 1;
    }


    emit(CartUpdated());
  }


}
