import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:norq/data/models/cart_model.dart';
import 'package:norq/data/models/product_model.dart';
import 'package:norq/service/sqlite_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  getCartItemfromLocalDB() async {
    emit(CartLoading());
    try {
      await SqlliteService.initializeDB();
      final data = await SqlliteService.getItems();
      print(data.first.title.toString());
      emit(CartSuccess(data));
    } catch (e) {
      emit(Cartfailure(e.toString()));
    }
  }

  deleteItemFromDB(int id) async {
    try {
      await SqlliteService.initializeDB();
      await SqlliteService.deleteitem(id.toString());

      emit(CartDelete());
    } catch (e) {
      emit(Cartfailure(e.toString()));
    }
  }

  updateItemCount(int id, int count) async {
    try {
      await SqlliteService.updateCount(id.toString(), count.toString());
      emit(CartCountUpadte());
    } catch (e) {
      emit(Cartfailure("Try Again"));
    }
  }
}
