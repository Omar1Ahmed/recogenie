part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartSuccess extends CartState {}
final class CartLoading extends CartState {}
final class CartEmpty extends CartState {}
final class CartError extends CartState {
  final String message;
  CartError(this.message);
}
final class CartUpdated extends CartState {}
final class CartClearLoading extends CartState {}
