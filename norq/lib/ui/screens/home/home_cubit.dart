import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:norq/data/models/cart_model.dart';
import 'package:norq/data/models/product_model.dart';
import 'package:norq/data/repositories/user_repository.dart';
import 'package:norq/service/sqlite_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRespository _userRespository;
  HomeCubit(this._userRespository) : super(HomeInitial());
  getProductList() async {
    emit(HomePageLoading());
    try {
      dynamic data = await _userRespository.fetchProducts();

      List<dynamic> productList = data.map((e) => Product.fromJson(e)).toList();

      print(productList);
      emit(HomePageSuccess(productList));
    } catch (e) {
      print(e.toString());
      emit(HomePageFailure(e.toString()));
    }
  }

  addtoCartItemToLocalDB(CartItem item) async {
    try {
      await SqlliteService.createItem(item);
    } catch (e) {
      print(e.toString());
    }
  }
}
