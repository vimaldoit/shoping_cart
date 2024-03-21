import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:norq/data/models/user_model.dart';
import 'package:norq/data/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRespository _userRespository;
  LoginCubit(this._userRespository) : super(LoginInitial());
  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await _userRespository.userLogin(email, password);
      UserModel userdata = await _userRespository.getUserData();
      emit(LoginSuccess(userdata));
    } catch (e) {
      emit(LoginFailuer(error: e.toString()));
    }
  }
}
