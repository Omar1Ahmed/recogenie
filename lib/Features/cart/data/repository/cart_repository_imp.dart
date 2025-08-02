import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recogenie/Features/cart/data/model/cart_model.dart';
import 'package:recogenie/Features/cart/domain/repository/cart_repository.dart';
import 'package:recogenie/Features/home/data/model/menu_item_model.dart';
import 'package:recogenie/core/error/failure.dart';
import 'package:recogenie/core/error/result.dart';
import 'package:recogenie/core/helper/Connectivity/connectivity_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helper/SupabaseNamesHelper/names_helper.dart';

@Injectable(as: CartRepository)
class CartRepositoryImp implements CartRepository  {
  final SupabaseClient _supabase;
  final FirebaseAuth _firebaseAuth;
  CartRepositoryImp(this._supabase, this._firebaseAuth);

  @override
  Future<Result> addToCart({required String menuItemId}) async {
    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

    final items = await _supabase.from(SupabaseNamesHelper.tables.cart.tableName).insert(CartModel(itemId: menuItemId, quantity: 1, userId: _firebaseAuth.currentUser!.uid).toJson());

    return Success(data: items);

    }on PostgrestException catch (e){

    return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }

  @override
  Future<Result> clearCart({required List<String> menuItemIds}) async {
    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

    final items = await _supabase.from(SupabaseNamesHelper.tables.cart.tableName).delete().inFilter(SupabaseNamesHelper.tables.cart.menuItemId, menuItemIds).eq(SupabaseNamesHelper.tables.cart.userId, _firebaseAuth.currentUser!.uid);

    return Success(data: items);

    }on PostgrestException catch (e){

    return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }

  @override
  Future<Result> removeFromCart({required String menuItemId}) async {
    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

    final items = await _supabase.from(SupabaseNamesHelper.tables.cart.tableName).delete().eq(SupabaseNamesHelper.tables.cart.menuItemId, menuItemId ).eq(SupabaseNamesHelper.tables.cart.userId, _firebaseAuth.currentUser!.uid);

    return Success(data: items);

    }on PostgrestException catch (e){
    return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }

  @override
  Future<Result> updateQuantity({required String menuItemId, required int quantity}) {
    // TODO: implement updateQuantity
    throw UnimplementedError();
  }

  @override
  Future<Result> fetchCartItems() async {

    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

    final items = await _supabase.from(SupabaseNamesHelper.tables.cart.tableName).select().eq(SupabaseNamesHelper.tables.cart.userId, _firebaseAuth.currentUser!.uid);

    return Success(data: CartItemsModel.fromJson(items).cartItems);

    }on PostgrestException catch (e){
    return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }


  @override
  Future<Result> fetchCartItemsDetails({required List<String> menuItemIds}) async {

    if(!(await ConnectivityHelper.isConnected())){
      return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

      final items = await _supabase.from(SupabaseNamesHelper.tables.menuItemsTable.tableName).select().inFilter(SupabaseNamesHelper.tables.menuItemsTable.id, menuItemIds);


      return Success(data: MenuItemsModel.fromJson(items).menuItems);

    }on PostgrestException catch (e){
      return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
      return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }

}