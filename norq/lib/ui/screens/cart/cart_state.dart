part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItem> cartData;

  CartSuccess(this.cartData);
}

class Cartfailure extends CartState {
  final String error;

  Cartfailure(this.error);
}

class CartDelete extends CartState {}

class CartCountUpadte extends CartState {}
